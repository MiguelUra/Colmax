-- Insertar notificaciones del sistema
-- IMPORTANTE: Ejecutar después de insertar usuarios y pedidos

/*
-- Obtener IDs necesarios:
-- SELECT id, full_name, role FROM public.users;
-- SELECT id, order_number FROM public.orders;

-- Notificaciones para clientes
-- Notificación 1: Pedido confirmado
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  related_order_id,
  is_read
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'Pedido Confirmado',
  'Tu pedido #COL-2024-001 ha sido confirmado y está siendo preparado. Tiempo estimado: 30 minutos.',
  'pedido',
  'UUID_ORDER_1',
  true
);

-- Notificación 2: Pedido en camino
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  related_order_id,
  is_read
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'Pedido en Camino',
  '¡Tu pedido #COL-2024-002 está en camino! El repartidor Luis llegará en aproximadamente 20 minutos.',
  'entrega',
  'UUID_ORDER_2',
  false
);

-- Notificación 3: Pedido entregado
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  related_order_id,
  is_read
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'Pedido Entregado',
  'Tu pedido #COL-2024-001 ha sido entregado exitosamente. ¡Esperamos que disfrutes tu comida!',
  'entrega',
  'UUID_ORDER_1',
  true
);

-- Notificación 4: Promoción disponible
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  is_read
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'Nueva Promoción Disponible',
  '¡Descuento del 20% en tu próximo pedido! Usa el código COLMAX20 antes del 31 de diciembre.',
  'promocion',
  false
);

-- Notificación 5: Recordatorio de reseña
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  related_order_id,
  is_read
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'Califica tu Experiencia',
  'Nos encantaría conocer tu opinión sobre el pedido #COL-2024-002. ¡Tu feedback nos ayuda a mejorar!',
  'sistema',
  'UUID_ORDER_2',
  false
);

-- Notificaciones para repartidores
-- Notificación 6: Nuevo pedido asignado
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  related_order_id,
  is_read
) VALUES (
  'UUID_REPARTIDOR_1', -- Luis Fernández
  'Nuevo Pedido Asignado',
  'Se te ha asignado el pedido #COL-2024-002. Dirígete a Supermercado La Familia para recogerlo.',
  'pedido',
  'UUID_ORDER_2',
  true
);

-- Notificación 7: Ruta optimizada
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  is_read
) VALUES (
  'UUID_REPARTIDOR_1', -- Luis Fernández
  'Ruta Optimizada',
  'Tu ruta de entrega ha sido optimizada. Tiempo estimado total: 45 minutos. Revisa los detalles en la app.',
  'entrega',
  false
);

-- Notificación 8: Bonificación por entrega
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  is_read
) VALUES (
  'UUID_REPARTIDOR_1', -- Luis Fernández
  'Bonificación Recibida',
  '¡Felicidades! Has recibido una bonificación de RD$50 por tu excelente calificación en las entregas.',
  'sistema',
  false
);

-- Notificaciones para propietarios de tiendas
-- Notificación 9: Nuevo pedido recibido
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  related_order_id,
  is_read
) VALUES (
  'UUID_OWNER_1', -- Carlos Rodríguez (propietario)
  'Nuevo Pedido Recibido',
  'Has recibido un nuevo pedido #COL-2024-003 por RD$320. Tiempo de preparación estimado: 25 minutos.',
  'pedido',
  'UUID_ORDER_3',
  true
);

-- Notificación 10: Producto agotado
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  is_read
) VALUES (
  'UUID_OWNER_2', -- Elena Vásquez (propietaria)
  'Producto Agotado',
  'El producto "Salmón a la Plancha" está agotado. Actualiza el inventario para seguir recibiendo pedidos.',
  'inventario',
  false
);

-- Notificación 11: Reseña recibida
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  is_read
) VALUES (
  'UUID_OWNER_1', -- Carlos Rodríguez
  'Nueva Reseña Recibida',
  'Has recibido una nueva reseña de 5 estrellas. ¡Sigue brindando un excelente servicio!',
  'sistema',
  false
);

-- Notificaciones del sistema
-- Notificación 12: Mantenimiento programado
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  is_read
) VALUES (
  'UUID_CLIENTE_1', -- Juan Pérez
  'Mantenimiento Programado',
  'El sistema estará en mantenimiento el domingo de 2:00 AM a 4:00 AM. Disculpa las molestias.',
  'sistema',
  false
);

-- Notificación 13: Nueva función disponible
INSERT INTO public.notifications (
  user_id,
  title,
  message,
  type,
  is_read
) VALUES (
  'UUID_CLIENTE_2', -- Ana Martínez
  'Nueva Función: Seguimiento en Tiempo Real',
  '¡Ahora puedes seguir tu pedido en tiempo real! Actualiza la app para disfrutar de esta nueva función.',
  'sistema',
  false
);
*/

-- INSTRUCCIONES:
-- 1. Ejecutar primero 02_test_users.sql y 06_orders.sql
-- 2. Obtener los UUIDs reales:
--    SELECT id, full_name, role FROM public.users;
--    SELECT id, order_number FROM public.orders;
-- 3. Reemplazar los UUIDs:
--    UUID_CLIENTE_1 = Juan Pérez
--    UUID_CLIENTE_2 = Ana Martínez
--    UUID_REPARTIDOR_1 = Luis Fernández
--    UUID_OWNER_1 = Carlos Rodríguez (propietario de tienda)
--    UUID_OWNER_2 = Elena Vásquez (propietaria de tienda)
--    UUID_ORDER_X = IDs correspondientes de los pedidos
-- 4. Ejecutar las consultas INSERT

-- Verificar inserción de notificaciones
-- SELECT n.title, n.message, n.type, n.is_read,
--        u.full_name as recipient, u.role,
--        o.order_number
-- FROM public.notifications n
-- JOIN public.users u ON n.user_id = u.id
-- LEFT JOIN public.orders o ON n.related_order_id = o.id
-- ORDER BY n.created_at DESC;

-- Notificaciones no leídas por usuario
-- SELECT u.full_name, u.role, COUNT(n.id) as unread_notifications
-- FROM public.users u
-- LEFT JOIN public.notifications n ON u.id = n.user_id AND n.is_read = false
-- GROUP BY u.id, u.full_name, u.role
-- ORDER BY unread_notifications DESC;

-- Notificaciones por tipo
-- SELECT type, COUNT(*) as total, 
--        COUNT(CASE WHEN is_read = false THEN 1 END) as unread
-- FROM public.notifications
-- GROUP BY type
-- ORDER BY total DESC;

-- Notificaciones recientes (últimas 24 horas)
-- SELECT n.title, n.message, u.full_name as recipient,
--        n.created_at
-- FROM public.notifications n
-- JOIN public.users u ON n.user_id = u.id
-- WHERE n.created_at >= NOW() - INTERVAL '24 hours'
-- ORDER BY n.created_at DESC;