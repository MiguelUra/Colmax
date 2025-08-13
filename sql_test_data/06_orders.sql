-- Insertar pedidos de prueba
-- IMPORTANTE: Ejecutar después de insertar usuarios, tiendas y productos

/*
-- Obtener IDs necesarios:
-- SELECT id, full_name, role FROM public.users WHERE role IN ('cliente', 'repartidor');
-- SELECT id, name FROM public.stores;
-- SELECT id, name, price FROM public.products;

-- Pedido 1: Pedido entregado
INSERT INTO public.orders (
  customer_id,
  store_id,
  delivery_person_id,
  order_number,
  status,
  subtotal,
  delivery_fee,
  total_amount,
  payment_method,
  delivery_address,
  delivery_location,
  customer_notes,
  estimated_delivery_time,
  delivered_at
) VALUES (
  'UUID_CLIENTE_1', -- Reemplazar con ID de Juan Pérez
  'UUID_STORE_1',   -- Reemplazar con ID de Colmado El Buen Precio
  'UUID_REPARTIDOR_1', -- Reemplazar con ID de Luis Fernández
  'COL-2024-001',
  'entregado',
  350.00,
  50.00,
  400.00,
  'efectivo',
  'Calle Conde #45, Zona Colonial, Santo Domingo',
  ST_GeogFromText('POINT(-69.9320 18.4850)'),
  'Tocar el timbre dos veces. Apartamento 2B.',
  NOW() - INTERVAL '2 hours',
  NOW() - INTERVAL '30 minutes'
);

-- Pedido 2: Pedido en camino
INSERT INTO public.orders (
  customer_id,
  store_id,
  delivery_person_id,
  order_number,
  status,
  subtotal,
  delivery_fee,
  total_amount,
  payment_method,
  is_priority,
  priority_fee,
  delivery_address,
  delivery_location,
  customer_notes,
  estimated_delivery_time
) VALUES (
  'UUID_CLIENTE_2', -- Reemplazar con ID de Ana Martínez
  'UUID_STORE_2',   -- Reemplazar con ID de Supermercado La Familia
  'UUID_REPARTIDOR_1', -- Reemplazar con ID de Luis Fernández
  'COL-2024-002',
  'en_camino',
  520.00,
  75.00,
  100.00, -- Priority fee
  695.00,
  'tarjeta',
  true,
  100.00,
  'Av. Abraham Lincoln #789, Piantini, Santo Domingo',
  ST_GeogFromText('POINT(-69.9180 18.4720)'),
  'Edificio Torre Empresarial, piso 15, oficina 1502.',
  NOW() + INTERVAL '20 minutes'
);

-- Pedido 3: Pedido preparando
INSERT INTO public.orders (
  customer_id,
  store_id,
  order_number,
  status,
  subtotal,
  delivery_fee,
  total_amount,
  payment_method,
  delivery_address,
  delivery_location,
  customer_notes,
  estimated_delivery_time
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'UUID_STORE_3',   -- Colmado Don Juan
  'COL-2024-003',
  'preparando',
  280.00,
  40.00,
  320.00,
  'transferencia',
  'Calle Mella #123, Santiago de los Caballeros',
  ST_GeogFromText('POINT(-70.6980 19.4520)'),
  'Casa color azul con portón blanco.',
  NOW() + INTERVAL '45 minutes'
);

-- Pedido 4: Pedido confirmado
INSERT INTO public.orders (
  customer_id,
  store_id,
  order_number,
  status,
  subtotal,
  delivery_fee,
  total_amount,
  payment_method,
  delivery_address,
  delivery_location,
  estimated_delivery_time
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'UUID_STORE_1',   -- Colmado El Buen Precio
  'COL-2024-004',
  'confirmado',
  180.00,
  50.00,
  230.00,
  'efectivo',
  'Av. Independencia #456, Santo Domingo',
  ST_GeogFromText('POINT(-69.9400 18.4800)'),
  NOW() + INTERVAL '1 hour'
);

-- Pedido 5: Pedido pendiente
INSERT INTO public.orders (
  customer_id,
  store_id,
  order_number,
  status,
  subtotal,
  delivery_fee,
  total_amount,
  payment_method,
  delivery_address,
  delivery_location,
  customer_notes
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'UUID_STORE_4',   -- Minimarket El Progreso
  'COL-2024-005',
  'pendiente',
  450.00,
  60.00,
  510.00,
  'tarjeta',
  'Calle Duarte #321, La Romana',
  ST_GeogFromText('POINT(-68.9730 18.4270)'),
  'Favor llamar al llegar, no hay timbre.'
);

-- Pedido 6: Pedido cancelado
INSERT INTO public.orders (
  customer_id,
  store_id,
  order_number,
  status,
  subtotal,
  delivery_fee,
  total_amount,
  payment_method,
  delivery_address,
  delivery_location
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'UUID_STORE_5',   -- Colmado Los Hermanos
  'COL-2024-006',
  'cancelado',
  200.00,
  45.00,
  245.00,
  'efectivo',
  'Av. Libertad #654, San Pedro de Macorís',
  ST_GeogFromText('POINT(-69.3090 18.4540)')
);
*/

-- INSTRUCCIONES:
-- 1. Ejecutar primero los archivos anteriores (02_test_users.sql, 03_stores.sql)
-- 2. Obtener los UUIDs reales:
--    SELECT id, full_name FROM public.users WHERE role = 'cliente';
--    SELECT id, full_name FROM public.users WHERE role = 'repartidor';
--    SELECT id, name FROM public.stores;
-- 3. Reemplazar los UUIDs:
--    UUID_CLIENTE_1 = Juan Pérez
--    UUID_CLIENTE_2 = Ana Martínez
--    UUID_REPARTIDOR_1 = Luis Fernández
--    UUID_STORE_X = IDs correspondientes de las tiendas
-- 4. Ejecutar las consultas INSERT

-- Verificar inserción
-- SELECT o.order_number, o.status, o.total_amount, 
--        c.full_name as customer, s.name as store,
--        r.full_name as delivery_person
-- FROM public.orders o
-- JOIN public.users c ON o.customer_id = c.id
-- JOIN public.stores s ON o.store_id = s.id
-- LEFT JOIN public.users r ON o.delivery_person_id = r.id
-- ORDER BY o.created_at DESC;