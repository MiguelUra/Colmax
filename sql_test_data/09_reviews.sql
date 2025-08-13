-- Insertar reseñas de productos y tiendas
-- IMPORTANTE: Ejecutar después de insertar usuarios, tiendas, productos y pedidos

/*
-- Obtener IDs necesarios:
-- SELECT id, full_name FROM public.users WHERE role = 'cliente';
-- SELECT id, name FROM public.stores;
-- SELECT id, name FROM public.products;
-- SELECT id, order_number FROM public.orders WHERE status = 'entregado';

-- Reseñas de productos
-- Reseña 1: Coca Cola 2L (del pedido entregado)
INSERT INTO public.reviews (
  user_id,
  product_id,
  order_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'UUID_PRODUCT_COCA_COLA', -- Coca Cola 2L
  'UUID_ORDER_1', -- COL-2024-001
  5,
  'Excelente producto, llegó bien frío y en perfectas condiciones. La botella estaba sellada correctamente.',
  'producto'
);

-- Reseña 2: Pollo Frito (del pedido entregado)
INSERT INTO public.reviews (
  user_id,
  product_id,
  order_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'UUID_PRODUCT_POLLO_FRITO', -- Pollo Frito Porción
  'UUID_ORDER_1', -- COL-2024-001
  4,
  'El pollo estaba sabroso y bien condimentado, aunque llegó un poco tibio. La porción es generosa.',
  'producto'
);

-- Reseña 3: Empanada (del pedido entregado)
INSERT INTO public.reviews (
  user_id,
  product_id,
  order_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'UUID_PRODUCT_EMPANADA', -- Empanada de Pollo
  'UUID_ORDER_1', -- COL-2024-001
  5,
  'Deliciosa empanada, masa crujiente y relleno abundante. Definitivamente la volvería a pedir.',
  'producto'
);

-- Reseñas de tiendas
-- Reseña 1: Colmado El Buen Precio
INSERT INTO public.reviews (
  user_id,
  store_id,
  order_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'UUID_STORE_1', -- Colmado El Buen Precio
  'UUID_ORDER_1', -- COL-2024-001
  5,
  'Excelente servicio, productos frescos y entrega rápida. El personal es muy amable y profesional.',
  'tienda'
);

-- Reseñas adicionales de otros clientes (simulando historial)
-- Reseña de Ana Martínez para un producto
INSERT INTO public.reviews (
  user_id,
  product_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'UUID_PRODUCT_ARROZ_POLLO', -- Arroz con Pollo
  4,
  'Muy buen sabor, el arroz estaba en su punto y el pollo tierno. Buena relación calidad-precio.',
  'producto'
);

-- Reseña de Ana Martínez para una tienda
INSERT INTO public.reviews (
  user_id,
  store_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'UUID_STORE_2', -- Supermercado La Familia
  5,
  'Gran variedad de productos, precios competitivos y excelente atención al cliente. Muy recomendado.',
  'tienda'
);

-- Reseña de Juan Pérez para otro producto
INSERT INTO public.reviews (
  user_id,
  product_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'UUID_PRODUCT_CERVEZA', -- Cerveza Presidente 355ml
  5,
  'Cerveza bien fría, perfecta para acompañar la comida. Llegó en tiempo récord.',
  'producto'
);

-- Reseña de Ana Martínez para Colmado Don Juan
INSERT INTO public.reviews (
  user_id,
  store_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'UUID_STORE_3', -- Colmado Don Juan
  4,
  'Buen servicio y productos de calidad. A veces tardan un poco en preparar los pedidos, pero vale la pena esperar.',
  'tienda'
);

-- Reseña para producto premium
INSERT INTO public.reviews (
  user_id,
  product_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'UUID_PRODUCT_SALMON', -- Salmón a la Plancha
  5,
  'Salmón fresco y bien preparado, cocción perfecta. Aunque es caro, la calidad lo justifica completamente.',
  'producto'
);

-- Reseña para producto orgánico
INSERT INTO public.reviews (
  user_id,
  product_id,
  rating,
  comment,
  review_type
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'UUID_PRODUCT_MANZANAS', -- Manzanas Orgánicas 1kg
  4,
  'Manzanas muy frescas y dulces, se nota que son orgánicas. El precio es un poco alto pero la calidad es excelente.',
  'producto'
);
*/

-- INSTRUCCIONES:
-- 1. Ejecutar primero los archivos anteriores (usuarios, tiendas, productos, pedidos)
-- 2. Obtener los UUIDs reales:
--    SELECT id, full_name FROM public.users WHERE role = 'cliente';
--    SELECT id, name FROM public.stores;
--    SELECT id, name FROM public.products;
--    SELECT id, order_number FROM public.orders;
-- 3. Reemplazar los UUIDs:
--    UUID_CLIENTE_1 = Juan Pérez
--    UUID_CLIENTE_2 = Ana Martínez
--    UUID_STORE_X = IDs correspondientes de las tiendas
--    UUID_PRODUCT_X = IDs correspondientes de los productos
--    UUID_ORDER_1 = Pedido COL-2024-001
-- 4. Ejecutar las consultas INSERT

-- Verificar inserción de reseñas de productos
-- SELECT r.rating, r.comment, u.full_name as reviewer, 
--        p.name as product, s.name as store
-- FROM public.reviews r
-- JOIN public.users u ON r.user_id = u.id
-- LEFT JOIN public.products p ON r.product_id = p.id
-- LEFT JOIN public.stores s ON p.store_id = s.id
-- WHERE r.review_type = 'producto'
-- ORDER BY r.created_at DESC;

-- Verificar inserción de reseñas de tiendas
-- SELECT r.rating, r.comment, u.full_name as reviewer, 
--        s.name as store
-- FROM public.reviews r
-- JOIN public.users u ON r.user_id = u.id
-- LEFT JOIN public.stores s ON r.store_id = s.id
-- WHERE r.review_type = 'tienda'
-- ORDER BY r.created_at DESC;

-- Estadísticas de reseñas por tienda
-- SELECT s.name as store, 
--        COUNT(r.id) as total_reviews,
--        ROUND(AVG(r.rating), 2) as average_rating
-- FROM public.stores s
-- LEFT JOIN public.reviews r ON s.id = r.store_id
-- GROUP BY s.id, s.name
-- ORDER BY average_rating DESC;

-- Estadísticas de reseñas por producto
-- SELECT p.name as product, s.name as store,
--        COUNT(r.id) as total_reviews,
--        ROUND(AVG(r.rating), 2) as average_rating
-- FROM public.products p
-- LEFT JOIN public.reviews r ON p.id = r.product_id
-- LEFT JOIN public.stores s ON p.store_id = s.id
-- GROUP BY p.id, p.name, s.name
-- HAVING COUNT(r.id) > 0
-- ORDER BY average_rating DESC, total_reviews DESC;