-- Políticas de Row Level Security (RLS) para Colmax
-- Garantiza que los usuarios solo puedan acceder a sus propios datos

-- Habilitar RLS en todas las tablas
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stores ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.deliveries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.delivery_routes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.route_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.promotions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Políticas para la tabla users
-- Los usuarios pueden ver y actualizar su propio perfil
CREATE POLICY "Users can view own profile" ON public.users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.users
  FOR UPDATE USING (auth.uid() = id);

-- Los usuarios pueden ver perfiles públicos de otros usuarios (para repartidores, dueños)
CREATE POLICY "Users can view public profiles" ON public.users
  FOR SELECT USING (true); -- Permitir ver todos los perfiles públicos

-- Solo usuarios autenticados pueden insertar (registro)
CREATE POLICY "Authenticated users can insert" ON public.users
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Políticas para la tabla stores
-- Todos pueden ver tiendas activas
CREATE POLICY "Anyone can view active stores" ON public.stores
  FOR SELECT USING (is_active = true);

-- Solo los dueños pueden crear tiendas
CREATE POLICY "Store owners can insert stores" ON public.stores
  FOR INSERT WITH CHECK (
    auth.uid() = owner_id AND 
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'dueno')
  );

-- Solo los dueños pueden actualizar sus propias tiendas
CREATE POLICY "Store owners can update own stores" ON public.stores
  FOR UPDATE USING (
    auth.uid() = owner_id AND 
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'dueno')
  );

-- Solo los dueños pueden eliminar sus propias tiendas
CREATE POLICY "Store owners can delete own stores" ON public.stores
  FOR DELETE USING (
    auth.uid() = owner_id AND 
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'dueno')
  );

-- Políticas para product_categories
-- Todos pueden ver categorías activas
CREATE POLICY "Anyone can view active categories" ON public.product_categories
  FOR SELECT USING (is_active = true);

-- Políticas para products
-- Todos pueden ver productos activos
CREATE POLICY "Anyone can view active products" ON public.products
  FOR SELECT USING (is_active = true);

-- Solo los dueños pueden gestionar productos de sus tiendas
CREATE POLICY "Store owners can manage own products" ON public.products
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.stores 
      WHERE id = store_id AND owner_id = auth.uid()
    )
  );

-- Políticas para orders
-- Los clientes pueden ver sus propios pedidos
CREATE POLICY "Customers can view own orders" ON public.orders
  FOR SELECT USING (auth.uid() = customer_id);

-- Los dueños pueden ver pedidos de sus tiendas
CREATE POLICY "Store owners can view store orders" ON public.orders
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.stores 
      WHERE id = store_id AND owner_id = auth.uid()
    )
  );

-- Los repartidores pueden ver pedidos asignados a ellos
CREATE POLICY "Delivery persons can view assigned orders" ON public.orders
  FOR SELECT USING (auth.uid() = delivery_person_id);

-- Los clientes pueden crear pedidos
CREATE POLICY "Customers can create orders" ON public.orders
  FOR INSERT WITH CHECK (
    auth.uid() = customer_id AND 
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'cliente')
  );

-- Los dueños pueden actualizar pedidos de sus tiendas
CREATE POLICY "Store owners can update store orders" ON public.orders
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM public.stores 
      WHERE id = store_id AND owner_id = auth.uid()
    )
  );

-- Los repartidores pueden actualizar pedidos asignados
CREATE POLICY "Delivery persons can update assigned orders" ON public.orders
  FOR UPDATE USING (auth.uid() = delivery_person_id);

-- Políticas para order_items
-- Acceso basado en el acceso al pedido
CREATE POLICY "Order items access based on order access" ON public.order_items
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.orders o
      WHERE o.id = order_id AND (
        o.customer_id = auth.uid() OR
        o.delivery_person_id = auth.uid() OR
        EXISTS (
          SELECT 1 FROM public.stores s
          WHERE s.id = o.store_id AND s.owner_id = auth.uid()
        )
      )
    )
  );

CREATE POLICY "Order items insert based on order ownership" ON public.order_items
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.orders o
      WHERE o.id = order_id AND o.customer_id = auth.uid()
    )
  );

-- Políticas para deliveries
-- Los repartidores pueden ver y gestionar sus propias entregas
CREATE POLICY "Delivery persons can manage own deliveries" ON public.deliveries
  FOR ALL USING (
    auth.uid() = delivery_person_id AND 
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'repartidor')
  );

-- Los dueños pueden ver entregas relacionadas con sus tiendas
CREATE POLICY "Store owners can view related deliveries" ON public.deliveries
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.orders o
      JOIN public.stores s ON s.id = o.store_id
      WHERE o.delivery_person_id = delivery_person_id AND s.owner_id = auth.uid()
    )
  );

-- Políticas para delivery_routes
-- Los repartidores pueden gestionar sus propias rutas
CREATE POLICY "Delivery persons can manage own routes" ON public.delivery_routes
  FOR ALL USING (
    auth.uid() = delivery_person_id AND 
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'repartidor')
  );

-- Políticas para route_orders
-- Acceso basado en el acceso a la ruta
CREATE POLICY "Route orders access based on route access" ON public.route_orders
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.delivery_routes dr
      WHERE dr.id = route_id AND dr.delivery_person_id = auth.uid()
    )
  );

-- Políticas para subscriptions
-- Los usuarios pueden ver sus propias suscripciones
CREATE POLICY "Users can view own subscriptions" ON public.subscriptions
  FOR SELECT USING (auth.uid() = user_id);

-- Los usuarios pueden crear sus propias suscripciones
CREATE POLICY "Users can create own subscriptions" ON public.subscriptions
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Los usuarios pueden actualizar sus propias suscripciones
CREATE POLICY "Users can update own subscriptions" ON public.subscriptions
  FOR UPDATE USING (auth.uid() = user_id);

-- Políticas para reviews
-- Todos pueden ver reseñas
CREATE POLICY "Anyone can view reviews" ON public.reviews
  FOR SELECT USING (true);

-- Solo los clientes pueden crear reseñas
CREATE POLICY "Customers can create reviews" ON public.reviews
  FOR INSERT WITH CHECK (
    auth.uid() = customer_id AND 
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'cliente')
  );

-- Los clientes pueden actualizar sus propias reseñas
CREATE POLICY "Customers can update own reviews" ON public.reviews
  FOR UPDATE USING (auth.uid() = customer_id);

-- Políticas para promotions
-- Todos pueden ver promociones activas
CREATE POLICY "Anyone can view active promotions" ON public.promotions
  FOR SELECT USING (is_active = true AND NOW() BETWEEN starts_at AND ends_at);

-- Solo los dueños pueden gestionar promociones de sus tiendas
CREATE POLICY "Store owners can manage own promotions" ON public.promotions
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.stores 
      WHERE id = store_id AND owner_id = auth.uid()
    )
  );

-- Políticas para notifications
-- Los usuarios pueden ver sus propias notificaciones
CREATE POLICY "Users can view own notifications" ON public.notifications
  FOR SELECT USING (auth.uid() = user_id);

-- Los usuarios pueden actualizar sus propias notificaciones (marcar como leídas)
CREATE POLICY "Users can update own notifications" ON public.notifications
  FOR UPDATE USING (auth.uid() = user_id);

-- Sistema puede insertar notificaciones para cualquier usuario
CREATE POLICY "System can insert notifications" ON public.notifications
  FOR INSERT WITH CHECK (true); -- Esto se manejará a través de funciones del servidor