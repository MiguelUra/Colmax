-- Migración inicial para la base de datos de Colmax
-- Esquema completo para digitalizar colmados dominicanos

-- Habilitar extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Enum para roles de usuario
CREATE TYPE user_role AS ENUM ('cliente', 'dueno', 'repartidor');

-- Enum para estados de pedidos
CREATE TYPE order_status AS ENUM (
  'pendiente',
  'confirmado', 
  'preparando',
  'en_camino',
  'entregado',
  'cancelado'
);

-- Enum para estados de repartidor
CREATE TYPE delivery_status AS ENUM ('disponible', 'ocupado', 'desconectado');

-- Enum para métodos de pago
CREATE TYPE payment_method AS ENUM ('efectivo', 'tarjeta', 'transferencia');

-- Tabla de usuarios (extiende auth.users de Supabase)
CREATE TABLE public.users (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT NOT NULL,
  phone TEXT,
  role user_role NOT NULL DEFAULT 'cliente',
  avatar_url TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de colmados/tiendas
CREATE TABLE public.stores (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  owner_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  address TEXT NOT NULL,
  phone TEXT,
  location GEOGRAPHY(POINT, 4326), -- Para geolocalización
  image_url TEXT,
  is_active BOOLEAN DEFAULT true,
  is_premium BOOLEAN DEFAULT false, -- Para aparecer primero en listados
  rating DECIMAL(2,1) DEFAULT 0.0,
  total_reviews INTEGER DEFAULT 0,
  delivery_fee DECIMAL(10,2) DEFAULT 50.00, -- Tarifa de entrega en RD$
  min_order_amount DECIMAL(10,2) DEFAULT 0.00, -- Monto mínimo de pedido
  estimated_delivery_time INTEGER DEFAULT 30, -- Tiempo estimado en minutos
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de categorías de productos
CREATE TABLE public.product_categories (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  icon_name TEXT, -- Nombre del icono para la UI
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de productos
CREATE TABLE public.products (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE NOT NULL,
  category_id UUID REFERENCES public.product_categories(id),
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  cost_price DECIMAL(10,2), -- Precio de costo para cálculos de ganancia
  stock_quantity INTEGER DEFAULT 0,
  min_stock_alert INTEGER DEFAULT 5, -- Alerta cuando el stock esté bajo
  image_url TEXT,
  barcode TEXT, -- Código de barras para escaneo
  is_active BOOLEAN DEFAULT true,
  is_featured BOOLEAN DEFAULT false, -- Producto destacado
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de pedidos
CREATE TABLE public.orders (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  customer_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE NOT NULL,
  delivery_person_id UUID REFERENCES public.users(id),
  order_number TEXT UNIQUE NOT NULL, -- Número de pedido legible
  status order_status DEFAULT 'pendiente',
  subtotal DECIMAL(10,2) NOT NULL,
  delivery_fee DECIMAL(10,2) DEFAULT 0.00,
  priority_fee DECIMAL(10,2) DEFAULT 0.00, -- Tarifa por entrega prioritaria
  total_amount DECIMAL(10,2) NOT NULL,
  payment_method payment_method DEFAULT 'efectivo',
  is_priority BOOLEAN DEFAULT false, -- Entrega prioritaria
  delivery_address TEXT NOT NULL,
  delivery_location GEOGRAPHY(POINT, 4326),
  customer_notes TEXT,
  estimated_delivery_time TIMESTAMP WITH TIME ZONE,
  delivered_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de items de pedidos
CREATE TABLE public.order_items (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE NOT NULL,
  product_id UUID REFERENCES public.products(id) ON DELETE CASCADE NOT NULL,
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(10,2) NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de entregas/rutas
CREATE TABLE public.deliveries (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  delivery_person_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  status delivery_status DEFAULT 'disponible',
  current_location GEOGRAPHY(POINT, 4326),
  cash_on_hand DECIMAL(10,2) DEFAULT 0.00, -- Efectivo que tiene el repartidor
  total_orders_today INTEGER DEFAULT 0,
  earnings_today DECIMAL(10,2) DEFAULT 0.00,
  started_shift_at TIMESTAMP WITH TIME ZONE,
  ended_shift_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de rutas de entrega
CREATE TABLE public.delivery_routes (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  delivery_person_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  route_data JSONB, -- Datos de la ruta optimizada
  total_distance DECIMAL(10,2), -- Distancia total en km
  estimated_time INTEGER, -- Tiempo estimado en minutos
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de asignación de pedidos a rutas
CREATE TABLE public.route_orders (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  route_id UUID REFERENCES public.delivery_routes(id) ON DELETE CASCADE NOT NULL,
  order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE NOT NULL,
  sequence_number INTEGER NOT NULL, -- Orden en la ruta
  is_completed BOOLEAN DEFAULT false,
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de suscripciones
CREATE TABLE public.subscriptions (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
  subscription_type TEXT NOT NULL, -- 'owner_monthly', 'customer_priority'
  amount DECIMAL(10,2) NOT NULL,
  is_active BOOLEAN DEFAULT true,
  starts_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  ends_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de reseñas
CREATE TABLE public.reviews (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  customer_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE NOT NULL,
  order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
  comment TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de ofertas y promociones
CREATE TABLE public.promotions (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  discount_type TEXT CHECK (discount_type IN ('percentage', 'fixed_amount')) NOT NULL,
  discount_value DECIMAL(10,2) NOT NULL,
  min_order_amount DECIMAL(10,2) DEFAULT 0.00,
  max_discount_amount DECIMAL(10,2),
  is_active BOOLEAN DEFAULT true,
  starts_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  ends_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de notificaciones
CREATE TABLE public.notifications (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  type TEXT DEFAULT 'info', -- 'info', 'success', 'warning', 'error'
  is_read BOOLEAN DEFAULT false,
  data JSONB, -- Datos adicionales para la notificación
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Índices para optimizar consultas
CREATE INDEX idx_stores_location ON public.stores USING GIST (location);
CREATE INDEX idx_stores_owner_id ON public.stores (owner_id);
CREATE INDEX idx_stores_is_active ON public.stores (is_active);
CREATE INDEX idx_products_store_id ON public.products (store_id);
CREATE INDEX idx_products_category_id ON public.products (category_id);
CREATE INDEX idx_products_is_active ON public.products (is_active);
CREATE INDEX idx_orders_customer_id ON public.orders (customer_id);
CREATE INDEX idx_orders_store_id ON public.orders (store_id);
CREATE INDEX idx_orders_delivery_person_id ON public.orders (delivery_person_id);
CREATE INDEX idx_orders_status ON public.orders (status);
CREATE INDEX idx_orders_created_at ON public.orders (created_at);
CREATE INDEX idx_order_items_order_id ON public.order_items (order_id);
CREATE INDEX idx_order_items_product_id ON public.order_items (product_id);
CREATE INDEX idx_deliveries_delivery_person_id ON public.deliveries (delivery_person_id);
CREATE INDEX idx_deliveries_status ON public.deliveries (status);
CREATE INDEX idx_notifications_user_id ON public.notifications (user_id);
CREATE INDEX idx_notifications_is_read ON public.notifications (is_read);

-- Triggers para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_stores_updated_at BEFORE UPDATE ON public.stores
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON public.products
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON public.orders
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_deliveries_updated_at BEFORE UPDATE ON public.deliveries
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();