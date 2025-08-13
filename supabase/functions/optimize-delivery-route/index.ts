// Supabase Edge Function para optimizar rutas de entrega
// Calcula la ruta más eficiente para múltiples pedidos

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

interface DeliveryPoint {
  orderId: string;
  latitude: number;
  longitude: number;
  address: string;
  customerName: string;
  totalAmount: number;
  isPriority: boolean;
}

interface OptimizedRoute {
  totalDistance: number;
  estimatedTime: number;
  orderedPoints: DeliveryPoint[];
  routeData: any;
}

// Función para calcular la distancia entre dos puntos usando la fórmula de Haversine
function calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const R = 6371; // Radio de la Tierra en km
  const dLat = (lat2 - lat1) * Math.PI / 180;
  const dLon = (lon2 - lon1) * Math.PI / 180;
  const a = 
    Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) * 
    Math.sin(dLon/2) * Math.sin(dLon/2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  return R * c;
}

// Algoritmo simple del vecino más cercano para optimizar la ruta
function optimizeRoute(
  startLat: number, 
  startLon: number, 
  points: DeliveryPoint[]
): OptimizedRoute {
  if (points.length === 0) {
    return {
      totalDistance: 0,
      estimatedTime: 0,
      orderedPoints: [],
      routeData: {}
    };
  }

  // Separar pedidos prioritarios y normales
  const priorityPoints = points.filter(p => p.isPriority);
  const normalPoints = points.filter(p => !p.isPriority);
  
  // Optimizar primero los pedidos prioritarios
  const optimizedPriority = optimizePointsOrder(startLat, startLon, priorityPoints);
  
  // Luego optimizar los pedidos normales desde el último punto prioritario
  let lastLat = startLat;
  let lastLon = startLon;
  
  if (optimizedPriority.length > 0) {
    const lastPriorityPoint = optimizedPriority[optimizedPriority.length - 1];
    lastLat = lastPriorityPoint.latitude;
    lastLon = lastPriorityPoint.longitude;
  }
  
  const optimizedNormal = optimizePointsOrder(lastLat, lastLon, normalPoints);
  
  // Combinar las rutas
  const orderedPoints = [...optimizedPriority, ...optimizedNormal];
  
  // Calcular distancia total y tiempo estimado
  let totalDistance = 0;
  let currentLat = startLat;
  let currentLon = startLon;
  
  for (const point of orderedPoints) {
    totalDistance += calculateDistance(currentLat, currentLon, point.latitude, point.longitude);
    currentLat = point.latitude;
    currentLon = point.longitude;
  }
  
  // Estimar tiempo: 30 km/h promedio en ciudad + 5 minutos por entrega
  const estimatedTime = Math.round((totalDistance / 30) * 60) + (orderedPoints.length * 5);
  
  return {
    totalDistance: Math.round(totalDistance * 100) / 100,
    estimatedTime,
    orderedPoints,
    routeData: {
      startPoint: { latitude: startLat, longitude: startLon },
      waypoints: orderedPoints.map(p => ({ 
        latitude: p.latitude, 
        longitude: p.longitude,
        orderId: p.orderId
      })),
      optimizedAt: new Date().toISOString()
    }
  };
}

// Optimizar el orden de un conjunto de puntos usando el algoritmo del vecino más cercano
function optimizePointsOrder(
  startLat: number, 
  startLon: number, 
  points: DeliveryPoint[]
): DeliveryPoint[] {
  if (points.length === 0) return [];
  if (points.length === 1) return points;
  
  const optimized: DeliveryPoint[] = [];
  const remaining = [...points];
  let currentLat = startLat;
  let currentLon = startLon;
  
  while (remaining.length > 0) {
    let nearestIndex = 0;
    let nearestDistance = calculateDistance(
      currentLat, 
      currentLon, 
      remaining[0].latitude, 
      remaining[0].longitude
    );
    
    // Encontrar el punto más cercano
    for (let i = 1; i < remaining.length; i++) {
      const distance = calculateDistance(
        currentLat, 
        currentLon, 
        remaining[i].latitude, 
        remaining[i].longitude
      );
      
      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestIndex = i;
      }
    }
    
    // Mover el punto más cercano a la ruta optimizada
    const nearestPoint = remaining.splice(nearestIndex, 1)[0];
    optimized.push(nearestPoint);
    currentLat = nearestPoint.latitude;
    currentLon = nearestPoint.longitude;
  }
  
  return optimized;
}

serve(async (req) => {
  // Configurar CORS
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  };

  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    // Inicializar cliente de Supabase
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      {
        global: {
          headers: { Authorization: req.headers.get('Authorization')! },
        },
      }
    );

    // Obtener datos del request
    const { deliveryPersonId, orderIds, startLocation } = await req.json();

    if (!deliveryPersonId || !orderIds || !Array.isArray(orderIds) || orderIds.length === 0) {
      return new Response(
        JSON.stringify({ error: 'Faltan parámetros requeridos' }),
        { 
          status: 400, 
          headers: { ...corsHeaders, 'Content-Type': 'application/json' } 
        }
      );
    }

    // Obtener información de los pedidos
    const { data: orders, error: ordersError } = await supabaseClient
      .from('orders')
      .select(`
        id,
        delivery_address,
        delivery_location,
        total_amount,
        is_priority,
        users!customer_id(full_name)
      `)
      .in('id', orderIds)
      .eq('delivery_person_id', deliveryPersonId);

    if (ordersError) {
      throw ordersError;
    }

    if (!orders || orders.length === 0) {
      return new Response(
        JSON.stringify({ error: 'No se encontraron pedidos válidos' }),
        { 
          status: 404, 
          headers: { ...corsHeaders, 'Content-Type': 'application/json' } 
        }
      );
    }

    // Convertir pedidos a puntos de entrega
    const deliveryPoints: DeliveryPoint[] = orders.map(order => {
      // Extraer coordenadas de la geometría PostGIS
      const coordinates = order.delivery_location?.coordinates || [0, 0];
      
      return {
        orderId: order.id,
        latitude: coordinates[1], // PostGIS usa [lon, lat]
        longitude: coordinates[0],
        address: order.delivery_address,
        customerName: order.users?.full_name || 'Cliente',
        totalAmount: order.total_amount,
        isPriority: order.is_priority || false
      };
    });

    // Usar ubicación de inicio proporcionada o ubicación por defecto
    const startLat = startLocation?.latitude || 18.4861; // Santo Domingo por defecto
    const startLon = startLocation?.longitude || -69.9312;

    // Optimizar la ruta
    const optimizedRoute = optimizeRoute(startLat, startLon, deliveryPoints);

    // Guardar la ruta en la base de datos
    const { data: routeData, error: routeError } = await supabaseClient
      .from('delivery_routes')
      .insert({
        delivery_person_id: deliveryPersonId,
        route_data: optimizedRoute.routeData,
        total_distance: optimizedRoute.totalDistance,
        estimated_time: optimizedRoute.estimatedTime,
        is_active: true
      })
      .select()
      .single();

    if (routeError) {
      throw routeError;
    }

    // Crear registros de route_orders
    const routeOrders = optimizedRoute.orderedPoints.map((point, index) => ({
      route_id: routeData.id,
      order_id: point.orderId,
      sequence_number: index + 1,
      is_completed: false
    }));

    const { error: routeOrdersError } = await supabaseClient
      .from('route_orders')
      .insert(routeOrders);

    if (routeOrdersError) {
      throw routeOrdersError;
    }

    // Respuesta exitosa
    return new Response(
      JSON.stringify({
        success: true,
        routeId: routeData.id,
        optimizedRoute: {
          ...optimizedRoute,
          orderedPoints: optimizedRoute.orderedPoints.map(point => ({
            ...point,
            // No incluir datos sensibles en la respuesta
          }))
        }
      }),
      { 
        status: 200, 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' } 
      }
    );

  } catch (error) {
    console.error('Error optimizando ruta:', error);
    
    return new Response(
      JSON.stringify({ 
        error: 'Error interno del servidor',
        details: error.message 
      }),
      { 
        status: 500, 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' } 
      }
    );
  }
});