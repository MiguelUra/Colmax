# Datos de Prueba para Colmax

Este directorio contiene archivos SQL con datos de prueba para la aplicación Colmax. Los archivos deben ejecutarse en el orden específico indicado a continuación.

## Orden de Ejecución

### 1. Categorías de Productos
**Archivo:** `01_product_categories.sql`
- ✅ **Listo para ejecutar** - No requiere dependencias
- Inserta 10 categorías de productos básicas

### 2. Usuarios de Prueba
**Archivo:** `02_test_users.sql`
- ⚠️ **Requiere configuración manual**
- **Pasos previos:**
  1. Registrar usuarios en Supabase Auth usando la interfaz de administración o la app
  2. Obtener los UUIDs reales de los usuarios registrados
  3. Reemplazar los placeholders en el archivo SQL

### 3. Tiendas
**Archivo:** `03_stores.sql`
- ⚠️ **Depende de:** `02_test_users.sql`
- Requiere UUIDs de usuarios con rol 'propietario'

### 4. Productos
**Archivo:** `04_products.sql`
- ⚠️ **Depende de:** `01_product_categories.sql` y `03_stores.sql`
- Requiere UUIDs de categorías y tiendas

### 5. Promociones
**Archivo:** `05_promotions.sql`
- ⚠️ **Depende de:** `03_stores.sql`
- Requiere UUIDs de tiendas

### 6. Pedidos
**Archivo:** `06_orders.sql`
- ⚠️ **Depende de:** `02_test_users.sql` y `03_stores.sql`
- Requiere UUIDs de clientes, repartidores y tiendas

### 7. Items de Pedidos
**Archivo:** `07_order_items.sql`
- ⚠️ **Depende de:** `04_products.sql` y `06_orders.sql`
- Requiere UUIDs de productos y pedidos

### 8. Entregas y Rutas
**Archivo:** `08_deliveries.sql`
- ⚠️ **Depende de:** `02_test_users.sql` y `06_orders.sql`
- Requiere UUIDs de repartidores y pedidos

### 9. Reseñas
**Archivo:** `09_reviews.sql`
- ⚠️ **Depende de:** `02_test_users.sql`, `03_stores.sql`, `04_products.sql` y `06_orders.sql`
- Requiere UUIDs de usuarios, tiendas, productos y pedidos

### 10. Notificaciones
**Archivo:** `10_notifications.sql`
- ⚠️ **Depende de:** `02_test_users.sql` y `06_orders.sql`
- Requiere UUIDs de usuarios y pedidos

## Instrucciones Detalladas

### Paso 1: Ejecutar Categorías
```sql
-- Ejecutar directamente en Supabase SQL Editor
\i 01_product_categories.sql
```

### Paso 2: Configurar Usuarios
1. **Registrar usuarios en Supabase Auth:**
   - Juan Pérez (cliente): `juan.perez@email.com`
   - Ana Martínez (cliente): `ana.martinez@email.com`
   - Carlos Rodríguez (propietario): `carlos.rodriguez@email.com`
   - Elena Vásquez (propietaria): `elena.vasquez@email.com`
   - Luis Fernández (repartidor): `luis.fernandez@email.com`
   - María González (repartidora): `maria.gonzalez@email.com`

2. **Obtener UUIDs:**
   ```sql
   SELECT id, email FROM auth.users ORDER BY created_at;
   ```

3. **Editar `02_test_users.sql`:**
   - Reemplazar `UUID_JUAN_PEREZ` con el UUID real
   - Reemplazar `UUID_ANA_MARTINEZ` con el UUID real
   - Y así sucesivamente...

4. **Ejecutar el archivo modificado**

### Paso 3: Continuar con el Resto
Para cada archivo subsecuente:

1. **Obtener UUIDs necesarios** usando las consultas SELECT proporcionadas en cada archivo
2. **Reemplazar placeholders** con los UUIDs reales
3. **Ejecutar las consultas INSERT**
4. **Verificar inserción** usando las consultas de verificación incluidas

## Consultas Útiles

### Obtener UUIDs de Usuarios por Rol
```sql
SELECT id, full_name, email, role 
FROM public.users 
ORDER BY role, full_name;
```

### Obtener UUIDs de Tiendas
```sql
SELECT id, name, owner_id 
FROM public.stores 
ORDER BY name;
```

### Obtener UUIDs de Categorías
```sql
SELECT id, name 
FROM public.product_categories 
ORDER BY name;
```

### Obtener UUIDs de Productos
```sql
SELECT p.id, p.name, p.price, s.name as store_name
FROM public.products p
JOIN public.stores s ON p.store_id = s.id
ORDER BY s.name, p.name;
```

### Verificar Estado General
```sql
-- Resumen de datos insertados
SELECT 
  'Categorías' as tabla, COUNT(*) as registros FROM public.product_categories
UNION ALL
SELECT 
  'Usuarios' as tabla, COUNT(*) as registros FROM public.users
UNION ALL
SELECT 
  'Tiendas' as tabla, COUNT(*) as registros FROM public.stores
UNION ALL
SELECT 
  'Productos' as tabla, COUNT(*) as registros FROM public.products
UNION ALL
SELECT 
  'Promociones' as tabla, COUNT(*) as registros FROM public.promotions
UNION ALL
SELECT 
  'Pedidos' as tabla, COUNT(*) as registros FROM public.orders
UNION ALL
SELECT 
  'Items de Pedidos' as tabla, COUNT(*) as registros FROM public.order_items
UNION ALL
SELECT 
  'Entregas' as tabla, COUNT(*) as registros FROM public.deliveries
UNION ALL
SELECT 
  'Reseñas' as tabla, COUNT(*) as registros FROM public.reviews
UNION ALL
SELECT 
  'Notificaciones' as tabla, COUNT(*) as registros FROM public.notifications;
```

## Notas Importantes

- ⚠️ **Políticas RLS:** Asegúrate de que las políticas de Row Level Security permitan la inserción de datos
- 🔐 **Autenticación:** Algunos datos requieren usuarios autenticados en Supabase Auth
- 📍 **Coordenadas:** Los datos incluyen coordenadas GPS reales de República Dominicana
- 💰 **Precios:** Todos los precios están en pesos dominicanos (RD$)
- 📱 **Realismo:** Los datos están diseñados para simular un entorno de producción realista

## Solución de Problemas

### Error: "new row violates row-level security policy"
- Verificar que el usuario esté autenticado en Supabase
- Revisar las políticas RLS en `002_rls_policies.sql`
- Considerar ejecutar como service_role si es necesario

### Error: "foreign key constraint"
- Verificar que las dependencias se hayan ejecutado en orden
- Confirmar que los UUIDs referenciados existen
- Revisar que no haya errores tipográficos en los UUIDs

### Error: "duplicate key value"
- Verificar que no se estén insertando datos duplicados
- Limpiar tablas si es necesario antes de re-ejecutar

---

**¡Listo!** Una vez completados todos los pasos, tendrás una base de datos completamente poblada con datos de prueba realistas para Colmax.