-- Insertar colmados de prueba
-- IMPORTANTE: Ejecutar después de insertar los usuarios (02_test_users.sql)
-- Reemplazar 'UUID_DUENO_1' y 'UUID_DUENO_2' con los IDs reales de los dueños

/*
-- Colmado 1: En Santo Domingo (Zona Colonial)
INSERT INTO public.stores (
  owner_id, 
  name, 
  description, 
  address, 
  phone, 
  location, 
  delivery_fee, 
  min_order_amount, 
  estimated_delivery_time,
  is_premium,
  rating
) VALUES (
  'UUID_DUENO_1', -- Reemplazar con UUID real de Carlos Rodríguez
  'Colmado El Buen Precio',
  'Tu colmado de confianza en el corazón de la Zona Colonial. Productos frescos y precios justos desde 1995.',
  'Calle Mercedes #123, Zona Colonial, Santo Domingo',
  '809-555-0101',
  ST_GeogFromText('POINT(-69.9312 18.4861)'), -- Zona Colonial
  50.00,
  200.00,
  30,
  true,
  4.5
);

-- Colmado 2: En Santo Domingo (Piantini)
INSERT INTO public.stores (
  owner_id, 
  name, 
  description, 
  address, 
  phone, 
  location, 
  delivery_fee, 
  min_order_amount, 
  estimated_delivery_time,
  is_premium,
  rating
) VALUES (
  'UUID_DUENO_2', -- Reemplazar con UUID real de María González
  'Supermercado La Familia',
  'Productos frescos y de calidad para toda la familia. Amplio surtido y excelente servicio.',
  'Av. Winston Churchill #456, Piantini, Santo Domingo',
  '809-555-0102',
  ST_GeogFromText('POINT(-69.9200 18.4700)'), -- Piantini
  75.00,
  300.00,
  45,
  true,
  4.7
);

-- Colmado 3: En Santiago
INSERT INTO public.stores (
  owner_id, 
  name, 
  description, 
  address, 
  phone, 
  location, 
  delivery_fee, 
  min_order_amount, 
  estimated_delivery_time,
  is_premium,
  rating
) VALUES (
  'UUID_DUENO_1', -- Carlos puede tener múltiples colmados
  'Colmado Don Juan',
  'Tradición y calidad desde 1985. El colmado de confianza del Cibao.',
  'Calle Duarte #789, Santiago de los Caballeros',
  '809-555-0103',
  ST_GeogFromText('POINT(-70.6970 19.4515)'), -- Santiago
  40.00,
  150.00,
  25,
  false,
  4.2
);

-- Colmado 4: En La Romana
INSERT INTO public.stores (
  owner_id, 
  name, 
  description, 
  address, 
  phone, 
  location, 
  delivery_fee, 
  min_order_amount, 
  estimated_delivery_time,
  is_premium,
  rating
) VALUES (
  'UUID_DUENO_2',
  'Minimarket El Progreso',
  'Servicio rápido y productos de calidad en el corazón de La Romana.',
  'Calle Libertad #321, La Romana',
  '809-555-0104',
  ST_GeogFromText('POINT(-68.9728 18.4273)'), -- La Romana
  60.00,
  250.00,
  35,
  false,
  4.0
);

-- Colmado 5: En San Pedro de Macorís
INSERT INTO public.stores (
  owner_id, 
  name, 
  description, 
  address, 
  phone, 
  location, 
  delivery_fee, 
  min_order_amount, 
  estimated_delivery_time,
  is_premium,
  rating
) VALUES (
  'UUID_DUENO_1',
  'Colmado Los Hermanos',
  'Atención familiar y productos frescos. Especialistas en productos del mar.',
  'Av. Independencia #654, San Pedro de Macorís',
  '809-555-0105',
  ST_GeogFromText('POINT(-69.3087 18.4539)'), -- San Pedro de Macorís
  45.00,
  180.00,
  28,
  false,
  4.3
);
*/

-- INSTRUCCIONES:
-- 1. Ejecutar primero 01_product_categories.sql y 02_test_users.sql
-- 2. Obtener los UUIDs reales de los dueños:
--    SELECT id, full_name FROM public.users WHERE role = 'dueno';
-- 3. Reemplazar 'UUID_DUENO_1' y 'UUID_DUENO_2' con los UUIDs correspondientes
-- 4. Ejecutar las consultas INSERT

-- Verificar inserción
-- SELECT s.name, u.full_name as owner, s.address, s.rating 
-- FROM public.stores s 
-- JOIN public.users u ON s.owner_id = u.id 
-- ORDER BY s.name;