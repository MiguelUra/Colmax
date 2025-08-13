-- Insertar promociones y ofertas especiales
-- IMPORTANTE: Ejecutar después de insertar las tiendas (03_stores.sql)

/*
-- Obtener IDs de las tiendas:
-- SELECT id, name FROM public.stores;

-- Promoción 1: Descuento porcentual en Colmado El Buen Precio
INSERT INTO public.promotions (
  store_id, 
  title, 
  description, 
  discount_type, 
  discount_value, 
  min_order_amount, 
  max_discount_amount,
  is_active, 
  starts_at, 
  ends_at
) VALUES (
  'UUID_STORE_1', -- Reemplazar con ID de Colmado El Buen Precio
  '20% de descuento en compras grandes',
  'Obtén 20% de descuento en compras mayores a RD$500. Válido hasta fin de mes.',
  'percentage',
  20.00,
  500.00,
  200.00, -- Máximo descuento RD$200
  true,
  NOW(),
  NOW() + INTERVAL '30 days'
);

-- Promoción 2: Envío gratis en Supermercado La Familia
INSERT INTO public.promotions (
  store_id, 
  title, 
  description, 
  discount_type, 
  discount_value, 
  min_order_amount, 
  is_active, 
  starts_at, 
  ends_at
) VALUES (
  'UUID_STORE_2', -- Reemplazar con ID de Supermercado La Familia
  'Envío GRATIS',
  'Envío completamente gratis en compras mayores a RD$800. ¡Aprovecha ahora!',
  'fixed_amount',
  75.00, -- Valor del envío que se descuenta
  800.00,
  true,
  NOW(),
  NOW() + INTERVAL '15 days'
);

-- Promoción 3: Descuento fijo en Colmado Don Juan
INSERT INTO public.promotions (
  store_id, 
  title, 
  description, 
  discount_type, 
  discount_value, 
  min_order_amount, 
  is_active, 
  starts_at, 
  ends_at
) VALUES (
  'UUID_STORE_3', -- Reemplazar con ID de Colmado Don Juan
  'RD$50 de descuento',
  'Descuento fijo de RD$50 en tu primera compra mayor a RD$300.',
  'fixed_amount',
  50.00,
  300.00,
  true,
  NOW(),
  NOW() + INTERVAL '45 days'
);

-- Promoción 4: Oferta especial de fin de semana
INSERT INTO public.promotions (
  store_id, 
  title, 
  description, 
  discount_type, 
  discount_value, 
  min_order_amount, 
  max_discount_amount,
  is_active, 
  starts_at, 
  ends_at
) VALUES (
  'UUID_STORE_1', -- Colmado El Buen Precio
  'Viernes de Ofertas - 15% OFF',
  'Todos los viernes 15% de descuento en bebidas y snacks. ¡No te lo pierdas!',
  'percentage',
  15.00,
  200.00,
  100.00,
  true,
  NOW(),
  NOW() + INTERVAL '60 days'
);

-- Promoción 5: Combo familiar
INSERT INTO public.promotions (
  store_id, 
  title, 
  description, 
  discount_type, 
  discount_value, 
  min_order_amount, 
  is_active, 
  starts_at, 
  ends_at
) VALUES (
  'UUID_STORE_2', -- Supermercado La Familia
  'Combo Familiar - RD$100 OFF',
  'Descuento especial de RD$100 en compras familiares mayores a RD$1,000.',
  'fixed_amount',
  100.00,
  1000.00,
  true,
  NOW(),
  NOW() + INTERVAL '20 days'
);

-- Promoción 6: Descuento para nuevos clientes
INSERT INTO public.promotions (
  store_id, 
  title, 
  description, 
  discount_type, 
  discount_value, 
  min_order_amount, 
  max_discount_amount,
  is_active, 
  starts_at, 
  ends_at
) VALUES (
  'UUID_STORE_4', -- Reemplazar con ID de Minimarket El Progreso
  'Bienvenido - 25% OFF',
  'Descuento especial del 25% para nuevos clientes. ¡Bienvenido a nuestra familia!',
  'percentage',
  25.00,
  150.00,
  75.00,
  true,
  NOW(),
  NOW() + INTERVAL '90 days'
);

-- Promoción 7: Oferta de temporada
INSERT INTO public.promotions (
  store_id, 
  title, 
  description, 
  discount_type, 
  discount_value, 
  min_order_amount, 
  is_active, 
  starts_at, 
  ends_at
) VALUES (
  'UUID_STORE_5', -- Reemplazar con ID de Colmado Los Hermanos
  'Especial del Mar - RD$30 OFF',
  'Descuento especial en productos del mar y mariscos frescos.',
  'fixed_amount',
  30.00,
  250.00,
  true,
  NOW(),
  NOW() + INTERVAL '14 days'
);
*/

-- INSTRUCCIONES:
-- 1. Ejecutar primero 03_stores.sql
-- 2. Obtener los UUIDs reales de las tiendas:
--    SELECT id, name FROM public.stores ORDER BY name;
-- 3. Reemplazar UUID_STORE_X con los IDs correspondientes:
--    UUID_STORE_1 = Colmado El Buen Precio
--    UUID_STORE_2 = Supermercado La Familia
--    UUID_STORE_3 = Colmado Don Juan
--    UUID_STORE_4 = Minimarket El Progreso
--    UUID_STORE_5 = Colmado Los Hermanos
-- 4. Ejecutar las consultas INSERT

-- Verificar inserción
-- SELECT p.title, p.discount_type, p.discount_value, s.name as store, 
--        p.starts_at, p.ends_at, p.is_active
-- FROM public.promotions p 
-- JOIN public.stores s ON p.store_id = s.id 
-- ORDER BY s.name, p.title;