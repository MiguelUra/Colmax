-- Insertar entregas y rutas de entrega
-- IMPORTANTE: Ejecutar después de insertar pedidos y usuarios (repartidores)

/*
-- Obtener IDs necesarios:
-- SELECT id, order_number FROM public.orders;
-- SELECT id, full_name FROM public.users WHERE role = 'repartidor';

-- Entrega 1: Pedido entregado (COL-2024-001)
INSERT INTO public.deliveries (
  order_id,
  delivery_person_id,
  status,
  pickup_time,
  delivery_time,
  delivery_notes,
  delivery_rating,
  customer_feedback
) VALUES (
  'UUID_ORDER_1', -- COL-2024-001
  'UUID_REPARTIDOR_1', -- Luis Fernández
  'entregado',
  NOW() - INTERVAL '2 hours 30 minutes',
  NOW() - INTERVAL '30 minutes',
  'Entrega realizada sin inconvenientes. Cliente muy amable.',
  5,
  'Excelente servicio, muy rápido y el repartidor fue muy cortés.'
);

-- Entrega 2: Pedido en camino (COL-2024-002)
INSERT INTO public.deliveries (
  order_id,
  delivery_person_id,
  status,
  pickup_time,
  estimated_delivery_time,
  delivery_notes
) VALUES (
  'UUID_ORDER_2', -- COL-2024-002
  'UUID_REPARTIDOR_1', -- Luis Fernández
  'en_camino',
  NOW() - INTERVAL '15 minutes',
  NOW() + INTERVAL '20 minutes',
  'Pedido recogido. Dirigiéndose a Piantini. Tráfico moderado.'
);

-- Entrega 3: Pedido preparando (COL-2024-003)
INSERT INTO public.deliveries (
  order_id,
  delivery_person_id,
  status,
  estimated_pickup_time,
  estimated_delivery_time
) VALUES (
  'UUID_ORDER_3', -- COL-2024-003
  'UUID_REPARTIDOR_2', -- María González
  'preparando',
  NOW() + INTERVAL '15 minutes',
  NOW() + INTERVAL '45 minutes'
);

-- Ruta de entrega 1: Ruta activa de Luis Fernández
INSERT INTO public.delivery_routes (
  delivery_person_id,
  route_name,
  status,
  start_location,
  current_location,
  estimated_completion_time
) VALUES (
  'UUID_REPARTIDOR_1', -- Luis Fernández
  'Ruta Santo Domingo Centro - Piantini',
  'activa',
  ST_GeogFromText('POINT(-69.9320 18.4850)'), -- Zona Colonial
  ST_GeogFromText('POINT(-69.9250 18.4780)'), -- En camino a Piantini
  NOW() + INTERVAL '25 minutes'
);

-- Ruta de entrega 2: Ruta planificada de María González
INSERT INTO public.delivery_routes (
  delivery_person_id,
  route_name,
  status,
  start_location,
  estimated_start_time,
  estimated_completion_time
) VALUES (
  'UUID_REPARTIDOR_2', -- María González
  'Ruta Santiago Centro',
  'planificada',
  ST_GeogFromText('POINT(-70.6980 19.4520)'), -- Santiago
  NOW() + INTERVAL '10 minutes',
  NOW() + INTERVAL '50 minutes'
);

-- Asociar pedidos con rutas
-- Pedido 1 ya entregado (ruta completada)
INSERT INTO public.route_orders (
  route_id,
  order_id,
  sequence_number,
  status,
  estimated_arrival_time,
  actual_arrival_time
) VALUES (
  (SELECT id FROM public.delivery_routes WHERE route_name = 'Ruta Santo Domingo Centro - Piantini'),
  'UUID_ORDER_1', -- COL-2024-001
  1,
  'completado',
  NOW() - INTERVAL '35 minutes',
  NOW() - INTERVAL '30 minutes'
);

-- Pedido 2 en camino
INSERT INTO public.route_orders (
  route_id,
  order_id,
  sequence_number,
  status,
  estimated_arrival_time
) VALUES (
  (SELECT id FROM public.delivery_routes WHERE route_name = 'Ruta Santo Domingo Centro - Piantini'),
  'UUID_ORDER_2', -- COL-2024-002
  2,
  'en_camino',
  NOW() + INTERVAL '20 minutes'
);

-- Pedido 3 en ruta planificada
INSERT INTO public.route_orders (
  route_id,
  order_id,
  sequence_number,
  status,
  estimated_arrival_time
) VALUES (
  (SELECT id FROM public.delivery_routes WHERE route_name = 'Ruta Santiago Centro'),
  'UUID_ORDER_3', -- COL-2024-003
  1,
  'planificado',
  NOW() + INTERVAL '45 minutes'
);
*/

-- INSTRUCCIONES:
-- 1. Ejecutar primero 02_test_users.sql y 06_orders.sql
-- 2. Obtener los UUIDs reales:
--    SELECT id, order_number FROM public.orders ORDER BY order_number;
--    SELECT id, full_name FROM public.users WHERE role = 'repartidor';
-- 3. Reemplazar los UUIDs:
--    UUID_ORDER_1 = Pedido COL-2024-001
--    UUID_ORDER_2 = Pedido COL-2024-002
--    UUID_ORDER_3 = Pedido COL-2024-003
--    UUID_REPARTIDOR_1 = Luis Fernández
--    UUID_REPARTIDOR_2 = María González
-- 4. Ejecutar las consultas INSERT

-- Verificar inserción de entregas
-- SELECT d.status, o.order_number, u.full_name as delivery_person,
--        d.pickup_time, d.delivery_time, d.delivery_rating
-- FROM public.deliveries d
-- JOIN public.orders o ON d.order_id = o.id
-- JOIN public.users u ON d.delivery_person_id = u.id
-- ORDER BY d.created_at;

-- Verificar rutas de entrega
-- SELECT dr.route_name, dr.status, u.full_name as delivery_person,
--        dr.estimated_completion_time
-- FROM public.delivery_routes dr
-- JOIN public.users u ON dr.delivery_person_id = u.id
-- ORDER BY dr.created_at;

-- Verificar asociación de pedidos con rutas
-- SELECT dr.route_name, o.order_number, ro.sequence_number, 
--        ro.status, ro.estimated_arrival_time
-- FROM public.route_orders ro
-- JOIN public.delivery_routes dr ON ro.route_id = dr.id
-- JOIN public.orders o ON ro.order_id = o.id
-- ORDER BY dr.route_name, ro.sequence_number;