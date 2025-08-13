-- Insertar items de pedidos
-- IMPORTANTE: Ejecutar después de insertar pedidos y productos

/*
-- Obtener IDs necesarios:
-- SELECT id, order_number FROM public.orders;
-- SELECT id, name, price FROM public.products;

-- Items para Pedido 1 (COL-2024-001) - Pedido entregado
-- Coca Cola 2L + Pollo Frito + Empanada
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('UUID_ORDER_1', 'UUID_PRODUCT_COCA_COLA', 1, 120.00, 120.00),
('UUID_ORDER_1', 'UUID_PRODUCT_POLLO_FRITO', 1, 180.00, 180.00),
('UUID_ORDER_1', 'UUID_PRODUCT_EMPANADA', 1, 45.00, 45.00);
-- Total: RD$345 + RD$5 (diferencia por redondeo/descuentos)

-- Items para Pedido 2 (COL-2024-002) - Pedido en camino (Premium)
-- Salmón + Ensalada César + Agua Evian
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('UUID_ORDER_2', 'UUID_PRODUCT_SALMON', 1, 450.00, 450.00),
('UUID_ORDER_2', 'UUID_PRODUCT_ENSALADA_CESAR', 1, 280.00, 280.00),
('UUID_ORDER_2', 'UUID_PRODUCT_AGUA_EVIAN', 2, 150.00, 300.00);
-- Total: RD$1,030 - descuento = RD$520

-- Items para Pedido 3 (COL-2024-003) - Pedido preparando
-- Arroz con Pollo + Cerveza Presidente + Pan de Agua
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('UUID_ORDER_3', 'UUID_PRODUCT_ARROZ_POLLO', 1, 220.00, 220.00),
('UUID_ORDER_3', 'UUID_PRODUCT_CERVEZA', 2, 80.00, 160.00),
('UUID_ORDER_3', 'UUID_PRODUCT_PAN_AGUA', 4, 25.00, 100.00);
-- Total: RD$480 - descuento = RD$280

-- Items para Pedido 4 (COL-2024-004) - Pedido confirmado
-- Sandwich Cubano + Agua Cristal
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('UUID_ORDER_4', 'UUID_PRODUCT_SANDWICH_CUBANO', 1, 150.00, 150.00),
('UUID_ORDER_4', 'UUID_PRODUCT_AGUA_CRISTAL', 1, 35.00, 35.00);
-- Total: RD$185 - descuento = RD$180

-- Items para Pedido 5 (COL-2024-005) - Pedido pendiente
-- Manzanas Orgánicas + Aguacates + Plátanos + Pasta Alfredo
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('UUID_ORDER_5', 'UUID_PRODUCT_MANZANAS', 1, 320.00, 320.00),
('UUID_ORDER_5', 'UUID_PRODUCT_AGUACATES', 1, 180.00, 180.00),
('UUID_ORDER_5', 'UUID_PRODUCT_PLATANOS', 1, 85.00, 85.00),
('UUID_ORDER_5', 'UUID_PRODUCT_PASTA_ALFREDO', 1, 380.00, 380.00);
-- Total: RD$965 - descuento = RD$450

-- Items para Pedido 6 (COL-2024-006) - Pedido cancelado
-- Queso de Freír + Leche Rica
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
('UUID_ORDER_6', 'UUID_PRODUCT_QUESO_FREIR', 1, 220.00, 220.00),
('UUID_ORDER_6', 'UUID_PRODUCT_LECHE_RICA', 2, 85.00, 170.00);
-- Total: RD$390 - descuento = RD$200
*/

-- INSTRUCCIONES:
-- 1. Ejecutar primero 04_products.sql y 06_orders.sql
-- 2. Obtener los UUIDs reales de pedidos:
--    SELECT id, order_number FROM public.orders ORDER BY order_number;
-- 3. Obtener los UUIDs reales de productos:
--    SELECT id, name, price FROM public.products ORDER BY name;
-- 4. Reemplazar los UUIDs correspondientes:

-- Mapeo de pedidos:
-- UUID_ORDER_1 = Pedido COL-2024-001
-- UUID_ORDER_2 = Pedido COL-2024-002
-- UUID_ORDER_3 = Pedido COL-2024-003
-- UUID_ORDER_4 = Pedido COL-2024-004
-- UUID_ORDER_5 = Pedido COL-2024-005
-- UUID_ORDER_6 = Pedido COL-2024-006

-- Mapeo de productos (buscar por nombre):
-- UUID_PRODUCT_COCA_COLA = 'Coca Cola 2L'
-- UUID_PRODUCT_POLLO_FRITO = 'Pollo Frito Porción'
-- UUID_PRODUCT_EMPANADA = 'Empanada de Pollo'
-- UUID_PRODUCT_SALMON = 'Salmón a la Plancha'
-- UUID_PRODUCT_ENSALADA_CESAR = 'Ensalada César Premium'
-- UUID_PRODUCT_AGUA_EVIAN = 'Agua Evian 1L'
-- UUID_PRODUCT_ARROZ_POLLO = 'Arroz con Pollo'
-- UUID_PRODUCT_CERVEZA = 'Cerveza Presidente 355ml'
-- UUID_PRODUCT_PAN_AGUA = 'Pan de Agua'
-- UUID_PRODUCT_SANDWICH_CUBANO = 'Sandwich Cubano'
-- UUID_PRODUCT_AGUA_CRISTAL = 'Agua Cristal 1L'
-- UUID_PRODUCT_MANZANAS = 'Manzanas Orgánicas 1kg'
-- UUID_PRODUCT_AGUACATES = 'Aguacates Premium 3 unidades'
-- UUID_PRODUCT_PLATANOS = 'Plátanos Orgánicos 1kg'
-- UUID_PRODUCT_PASTA_ALFREDO = 'Pasta Alfredo con Camarones'
-- UUID_PRODUCT_QUESO_FREIR = 'Queso de Freír 500g'
-- UUID_PRODUCT_LECHE_RICA = 'Leche Rica 1L'

-- 5. Ejecutar las consultas INSERT

-- Verificar inserción
-- SELECT o.order_number, p.name as product, oi.quantity, 
--        oi.unit_price, oi.total_price, s.name as store
-- FROM public.order_items oi
-- JOIN public.orders o ON oi.order_id = o.id
-- JOIN public.products p ON oi.product_id = p.id
-- JOIN public.stores s ON p.store_id = s.id
-- ORDER BY o.order_number, p.name;

-- Verificar totales de pedidos
-- SELECT o.order_number, o.subtotal as order_subtotal, 
--        SUM(oi.total_price) as items_total
-- FROM public.orders o
-- JOIN public.order_items oi ON o.id = oi.order_id
-- GROUP BY o.id, o.order_number, o.subtotal
-- ORDER BY o.order_number;