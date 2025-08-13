-- Insertar productos de prueba
-- IMPORTANTE: Ejecutar después de insertar categorías y colmados
-- Reemplazar los UUIDs con los IDs reales de las tablas correspondientes

/*
-- Obtener IDs necesarios:
-- SELECT id, name FROM public.product_categories;
-- SELECT id, name FROM public.stores;

-- PRODUCTOS PARA COLMADO EL BUEN PRECIO (Zona Colonial)
-- Bebidas
INSERT INTO public.products (store_id, category_id, name, description, price, cost_price, stock_quantity, image_url, is_featured) VALUES
('UUID_STORE_1', 'UUID_CAT_BEBIDAS', 'Coca Cola 2L', 'Refresco Coca Cola de 2 litros', 120.00, 85.00, 50, 'https://via.placeholder.com/300x300?text=Coca+Cola+2L', true),
('UUID_STORE_1', 'UUID_CAT_BEBIDAS', 'Agua Cristal 1L', 'Agua purificada Cristal de 1 litro', 35.00, 25.00, 100, 'https://via.placeholder.com/300x300?text=Agua+Cristal', false),
('UUID_STORE_1', 'UUID_CAT_BEBIDAS', 'Jugo Jumex Mango 500ml', 'Jugo de mango Jumex 500ml', 65.00, 45.00, 30, 'https://via.placeholder.com/300x300?text=Jumex+Mango', false),
('UUID_STORE_1', 'UUID_CAT_BEBIDAS', 'Cerveza Presidente 355ml', 'Cerveza Presidente lata 355ml', 80.00, 55.00, 60, 'https://via.placeholder.com/300x300?text=Presidente', true),
('UUID_STORE_1', 'UUID_CAT_BEBIDAS', 'Ron Barceló Añejo 750ml', 'Ron Barceló Añejo botella 750ml', 850.00, 650.00, 15, 'https://via.placeholder.com/300x300?text=Ron+Barcelo', false);

-- Comida
INSERT INTO public.products (store_id, category_id, name, description, price, cost_price, stock_quantity, image_url, is_featured) VALUES
('UUID_STORE_1', 'UUID_CAT_COMIDA', 'Pollo Frito Porción', 'Pollo frito crujiente, porción individual', 180.00, 120.00, 20, 'https://via.placeholder.com/300x300?text=Pollo+Frito', true),
('UUID_STORE_1', 'UUID_CAT_COMIDA', 'Empanada de Pollo', 'Empanada casera rellena de pollo', 45.00, 25.00, 25, 'https://via.placeholder.com/300x300?text=Empanada', false),
('UUID_STORE_1', 'UUID_CAT_COMIDA', 'Sandwich Cubano', 'Sandwich cubano con jamón, queso y pepinillos', 150.00, 100.00, 15, 'https://via.placeholder.com/300x300?text=Sandwich+Cubano', true),
('UUID_STORE_1', 'UUID_CAT_COMIDA', 'Arroz con Pollo', 'Arroz con pollo dominicano, porción grande', 220.00, 150.00, 12, 'https://via.placeholder.com/300x300?text=Arroz+Pollo', true),
('UUID_STORE_1', 'UUID_CAT_COMIDA', 'Tostones con Pollo', 'Tostones con pollo desmenuzado', 160.00, 110.00, 18, 'https://via.placeholder.com/300x300?text=Tostones', false);

-- Lácteos
INSERT INTO public.products (store_id, category_id, name, description, price, cost_price, stock_quantity, image_url, is_featured) VALUES
('UUID_STORE_1', 'UUID_CAT_LACTEOS', 'Leche Rica 1L', 'Leche entera Rica de 1 litro', 85.00, 65.00, 40, 'https://via.placeholder.com/300x300?text=Leche+Rica', false),
('UUID_STORE_1', 'UUID_CAT_LACTEOS', 'Queso de Freír 500g', 'Queso dominicano para freír, 500g', 220.00, 160.00, 25, 'https://via.placeholder.com/300x300?text=Queso+Freir', true),
('UUID_STORE_1', 'UUID_CAT_LACTEOS', 'Yogurt Yoplait Fresa', 'Yogurt Yoplait sabor fresa', 55.00, 35.00, 35, 'https://via.placeholder.com/300x300?text=Yogurt', false),
('UUID_STORE_1', 'UUID_CAT_LACTEOS', 'Mantequilla Dos Pinos 250g', 'Mantequilla Dos Pinos 250g', 180.00, 130.00, 20, 'https://via.placeholder.com/300x300?text=Mantequilla', false);

-- Panadería
INSERT INTO public.products (store_id, category_id, name, description, price, cost_price, stock_quantity, image_url, is_featured) VALUES
('UUID_STORE_1', 'UUID_CAT_PANADERIA', 'Pan Tostado Bimbo', 'Pan tostado Bimbo integral', 95.00, 70.00, 30, 'https://via.placeholder.com/300x300?text=Pan+Tostado', false),
('UUID_STORE_1', 'UUID_CAT_PANADERIA', 'Galletas Ducales', 'Galletas Ducales paquete familiar', 120.00, 85.00, 40, 'https://via.placeholder.com/300x300?text=Galletas', true),
('UUID_STORE_1', 'UUID_CAT_PANADERIA', 'Pan de Agua', 'Pan de agua fresco del día', 25.00, 15.00, 50, 'https://via.placeholder.com/300x300?text=Pan+Agua', false),
('UUID_STORE_1', 'UUID_CAT_PANADERIA', 'Cake Tres Leches', 'Cake tres leches individual', 180.00, 120.00, 8, 'https://via.placeholder.com/300x300?text=Tres+Leches', true);

-- PRODUCTOS PARA SUPERMERCADO LA FAMILIA (Piantini)
-- Bebidas Premium
INSERT INTO public.products (store_id, category_id, name, description, price, cost_price, stock_quantity, image_url, is_featured) VALUES
('UUID_STORE_2', 'UUID_CAT_BEBIDAS', 'Agua Evian 1L', 'Agua mineral Evian importada', 150.00, 110.00, 25, 'https://via.placeholder.com/300x300?text=Evian', true),
('UUID_STORE_2', 'UUID_CAT_BEBIDAS', 'Vino Tinto Marqués de Cáceres', 'Vino tinto español Marqués de Cáceres', 1200.00, 900.00, 10, 'https://via.placeholder.com/300x300?text=Vino+Tinto', true),
('UUID_STORE_2', 'UUID_CAT_BEBIDAS', 'Jugo de Naranja Natural 1L', 'Jugo de naranja recién exprimido', 120.00, 80.00, 15, 'https://via.placeholder.com/300x300?text=Jugo+Naranja', false);

-- Comida Gourmet
INSERT INTO public.products (store_id, category_id, name, description, price, cost_price, stock_quantity, image_url, is_featured) VALUES
('UUID_STORE_2', 'UUID_CAT_COMIDA', 'Salmón a la Plancha', 'Salmón fresco a la plancha con vegetales', 450.00, 320.00, 8, 'https://via.placeholder.com/300x300?text=Salmon', true),
('UUID_STORE_2', 'UUID_CAT_COMIDA', 'Ensalada César Premium', 'Ensalada César con pollo y aderezo casero', 280.00, 180.00, 12, 'https://via.placeholder.com/300x300?text=Ensalada+Cesar', false),
('UUID_STORE_2', 'UUID_CAT_COMIDA', 'Pasta Alfredo con Camarones', 'Pasta alfredo con camarones frescos', 380.00, 250.00, 10, 'https://via.placeholder.com/300x300?text=Pasta+Alfredo', true);

-- Productos Orgánicos
INSERT INTO public.products (store_id, category_id, name, description, price, cost_price, stock_quantity, image_url, is_featured) VALUES
('UUID_STORE_2', 'UUID_CAT_FRUTAS', 'Manzanas Orgánicas 1kg', 'Manzanas rojas orgánicas importadas', 320.00, 220.00, 20, 'https://via.placeholder.com/300x300?text=Manzanas+Organicas', true),
('UUID_STORE_2', 'UUID_CAT_FRUTAS', 'Aguacates Premium 3 unidades', 'Aguacates Hass premium', 180.00, 120.00, 30, 'https://via.placeholder.com/300x300?text=Aguacates', false),
('UUID_STORE_2', 'UUID_CAT_FRUTAS', 'Plátanos Orgánicos 1kg', 'Plátanos orgánicos locales', 85.00, 55.00, 40, 'https://via.placeholder.com/300x300?text=Platanos', false);
*/

-- INSTRUCCIONES:
-- 1. Ejecutar primero los archivos anteriores (01, 02, 03)
-- 2. Obtener los UUIDs reales:
--    SELECT id, name FROM public.stores ORDER BY name;
--    SELECT id, name FROM public.product_categories ORDER BY name;
-- 3. Reemplazar todos los UUID_STORE_X y UUID_CAT_X con los IDs correspondientes
-- 4. Ejecutar las consultas INSERT

-- Mapeo de categorías (para referencia):
-- UUID_CAT_BEBIDAS = ID de 'Bebidas'
-- UUID_CAT_COMIDA = ID de 'Comida'
-- UUID_CAT_LACTEOS = ID de 'Lácteos'
-- UUID_CAT_PANADERIA = ID de 'Panadería'
-- UUID_CAT_FRUTAS = ID de 'Frutas y Vegetales'

-- Mapeo de tiendas (para referencia):
-- UUID_STORE_1 = ID de 'Colmado El Buen Precio'
-- UUID_STORE_2 = ID de 'Supermercado La Familia'

-- Verificar inserción
-- SELECT p.name, p.price, s.name as store, c.name as category 
-- FROM public.products p 
-- JOIN public.stores s ON p.store_id = s.id 
-- JOIN public.product_categories c ON p.category_id = c.id 
-- ORDER BY s.name, c.name, p.name;