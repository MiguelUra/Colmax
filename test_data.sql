-- Datos de prueba para la base de datos Colmax
-- Este archivo contiene información de ejemplo para probar la aplicación

-- Insertar categorías de productos
INSERT INTO public.product_categories (name, description, icon_name, is_active) VALUES
('Bebidas', 'Refrescos, jugos, agua y bebidas alcohólicas', 'local_drink', true),
('Comida', 'Alimentos preparados, snacks y comida rápida', 'restaurant', true),
('Lácteos', 'Leche, queso, yogurt y productos lácteos', 'local_grocery_store', true),
('Panadería', 'Pan, galletas, pasteles y productos de panadería', 'bakery_dining', true),
('Limpieza', 'Productos de limpieza y cuidado del hogar', 'cleaning_services', true),
('Higiene Personal', 'Productos de cuidado personal e higiene', 'face', true),
('Medicinas', 'Medicamentos básicos y productos farmacéuticos', 'local_pharmacy', true),
('Frutas y Vegetales', 'Frutas frescas, vegetales y productos agrícolas', 'eco', true);

-- Insertar usuarios de prueba (estos IDs deben coincidir con usuarios reales de Supabase Auth)
-- Nota: En producción, estos usuarios se crearían a través del sistema de autenticación

-- Insertar colmados de prueba
-- Primero necesitamos usuarios dueños, pero como dependen de auth.users, 
-- crearemos los colmados después de que se registren usuarios reales

-- Datos de ejemplo que se pueden insertar una vez que tengamos usuarios registrados:

-- Ejemplo de colmado en Santo Domingo
/*
INSERT INTO public.stores (owner_id, name, description, address, phone, location, delivery_fee, min_order_amount, estimated_delivery_time) VALUES
('USER_ID_AQUI', 'Colmado El Buen Precio', 'Tu colmado de confianza en el corazón de Santo Domingo', 'Calle Mercedes #123, Zona Colonial, Santo Domingo', '809-555-0101', ST_GeogFromText('POINT(-69.9312 18.4861)'), 50.00, 200.00, 30),
('USER_ID_AQUI', 'Supermercado La Familia', 'Productos frescos y de calidad para toda la familia', 'Av. Winston Churchill #456, Piantini', '809-555-0102', ST_GeogFromText('POINT(-69.9200 18.4700)'), 75.00, 300.00, 45),
('USER_ID_AQUI', 'Colmado Don Juan', 'Tradición y calidad desde 1985', 'Calle Duarte #789, Santiago', '809-555-0103', ST_GeogFromText('POINT(-70.6970 19.4515)'), 40.00, 150.00, 25);
*/

-- Productos de ejemplo (se insertarán después de tener colmados)
/*
INSERT INTO public.products (store_id, category_id, name, description, price, stock_quantity, image_url, is_featured) VALUES
-- Bebidas
('STORE_ID_AQUI', 'CATEGORY_ID_BEBIDAS', 'Coca Cola 2L', 'Refresco Coca Cola de 2 litros', 120.00, 50, 'https://example.com/coca-cola-2l.jpg', true),
('STORE_ID_AQUI', 'CATEGORY_ID_BEBIDAS', 'Agua Cristal 1L', 'Agua purificada Cristal de 1 litro', 35.00, 100, 'https://example.com/agua-cristal.jpg', false),
('STORE_ID_AQUI', 'CATEGORY_ID_BEBIDAS', 'Jugo Jumex Mango', 'Jugo de mango Jumex 500ml', 65.00, 30, 'https://example.com/jumex-mango.jpg', false),

-- Comida
('STORE_ID_AQUI', 'CATEGORY_ID_COMIDA', 'Pollo Frito', 'Pollo frito crujiente, porción individual', 180.00, 20, 'https://example.com/pollo-frito.jpg', true),
('STORE_ID_AQUI', 'CATEGORY_ID_COMIDA', 'Empanada de Pollo', 'Empanada casera rellena de pollo', 45.00, 25, 'https://example.com/empanada-pollo.jpg', false),
('STORE_ID_AQUI', 'CATEGORY_ID_COMIDA', 'Sandwich Cubano', 'Sandwich cubano con jamón, queso y pepinillos', 150.00, 15, 'https://example.com/sandwich-cubano.jpg', true),

-- Lácteos
('STORE_ID_AQUI', 'CATEGORY_ID_LACTEOS', 'Leche Rica 1L', 'Leche entera Rica de 1 litro', 85.00, 40, 'https://example.com/leche-rica.jpg', false),
('STORE_ID_AQUI', 'CATEGORY_ID_LACTEOS', 'Queso de Freír', 'Queso dominicano para freír, 500g', 220.00, 25, 'https://example.com/queso-freir.jpg', true),
('STORE_ID_AQUI', 'CATEGORY_ID_LACTEOS', 'Yogurt Yoplait', 'Yogurt Yoplait sabor fresa', 55.00, 35, 'https://example.com/yogurt-yoplait.jpg', false);
*/

-- Promociones de ejemplo
/*
INSERT INTO public.promotions (store_id, title, description, discount_type, discount_value, min_order_amount, starts_at, ends_at) VALUES
('STORE_ID_AQUI', '20% de descuento', 'Descuento del 20% en compras mayores a RD$500', 'percentage', 20.00, 500.00, NOW(), NOW() + INTERVAL '30 days'),
('STORE_ID_AQUI', 'Envío gratis', 'Envío gratis en compras mayores a RD$800', 'fixed_amount', 50.00, 800.00, NOW(), NOW() + INTERVAL '15 days');
*/

-- Notificaciones de ejemplo
/*
INSERT INTO public.notifications (user_id, title, message, type) VALUES
('USER_ID_AQUI', '¡Bienvenido a Colmax!', 'Gracias por registrarte en Colmax. Explora los colmados cerca de ti.', 'success'),
('USER_ID_AQUI', 'Promoción especial', 'Hay una nueva promoción en tu colmado favorito. ¡No te la pierdas!', 'info');
*/

-- Comentario: Para insertar datos completos, necesitamos:
-- 1. Usuarios registrados en Supabase Auth
-- 2. Sus IDs correspondientes en la tabla public.users
-- 3. Colmados creados con esos owner_ids
-- 4. Productos asociados a esos colmados
-- 5. Pedidos y otros datos relacionales

-- Este archivo sirve como plantilla para los datos de prueba
-- Los IDs reales se deben obtener después del registro de usuarios