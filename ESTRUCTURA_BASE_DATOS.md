# Estructura Completa de la Base de Datos - Colmax

## Descripción General
Esta es la estructura completa de la base de datos para **Colmax**, una aplicación para digitalizar colmados dominicanos. La base de datos está diseñada con PostgreSQL y Supabase, implementando Row Level Security (RLS) para garantizar la seguridad de los datos.

## Extensiones Habilitadas
```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";
```

## Tipos Enumerados (ENUMs)

### user_role
```sql
CREATE TYPE user_role AS ENUM ('cliente', 'dueno', 'repartidor');
```

### order_status
```sql
CREATE TYPE order_status AS ENUM (
  'pendiente',
  'confirmado', 
  'preparando',
  'en_camino',
  'entregado',
  'cancelado'
);
```

### delivery_status
```sql
CREATE TYPE delivery_status AS ENUM ('disponible', 'ocupado', 'desconectado');
```

### payment_method
```sql
CREATE TYPE payment_method AS ENUM ('efectivo', 'tarjeta', 'transferencia');
```

## Estructura de Tablas

### 1. users
**Descripción**: Extiende la tabla auth.users de Supabase con información adicional del usuario.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Referencia a auth.users(id) |
| email | TEXT | Email único del usuario |
| full_name | TEXT | Nombre completo |
| phone | TEXT | Número de teléfono |
| role | user_role | Rol del usuario (cliente, dueno, repartidor) |
| avatar_url | TEXT | URL del avatar |
| is_active | BOOLEAN | Estado activo del usuario |
| created_at | TIMESTAMP | Fecha de creación |
| updated_at | TIMESTAMP | Fecha de última actualización |

**Relaciones**:
- Referencia a `auth.users(id)` con CASCADE DELETE

### 2. stores
**Descripción**: Información de los colmados/tiendas registradas.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| owner_id | UUID (FK) | Referencia al dueño (users.id) |
| name | TEXT | Nombre del colmado |
| description | TEXT | Descripción del negocio |
| address | TEXT | Dirección física |
| phone | TEXT | Teléfono de contacto |
| location | GEOGRAPHY(POINT) | Coordenadas geográficas |
| image_url | TEXT | URL de la imagen del colmado |
| is_active | BOOLEAN | Estado activo |
| is_premium | BOOLEAN | Suscripción premium |
| rating | DECIMAL(2,1) | Calificación promedio |
| total_reviews | INTEGER | Total de reseñas |
| delivery_fee | DECIMAL(10,2) | Tarifa de entrega en RD$ |
| min_order_amount | DECIMAL(10,2) | Monto mínimo de pedido |
| estimated_delivery_time | INTEGER | Tiempo estimado en minutos |
| created_at | TIMESTAMP | Fecha de creación |
| updated_at | TIMESTAMP | Fecha de última actualización |

**Relaciones**:
- `owner_id` → `users(id)` con CASCADE DELETE

### 3. product_categories
**Descripción**: Categorías de productos disponibles.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| name | TEXT | Nombre de la categoría |
| description | TEXT | Descripción |
| icon_name | TEXT | Nombre del icono para UI |
| is_active | BOOLEAN | Estado activo |
| created_at | TIMESTAMP | Fecha de creación |

### 4. products
**Descripción**: Productos disponibles en cada colmado.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| store_id | UUID (FK) | Referencia al colmado |
| category_id | UUID (FK) | Referencia a la categoría |
| name | TEXT | Nombre del producto |
| description | TEXT | Descripción |
| price | DECIMAL(10,2) | Precio de venta |
| cost_price | DECIMAL(10,2) | Precio de costo |
| stock_quantity | INTEGER | Cantidad en inventario |
| min_stock_alert | INTEGER | Alerta de stock mínimo |
| image_url | TEXT | URL de la imagen |
| barcode | TEXT | Código de barras |
| is_active | BOOLEAN | Estado activo |
| is_featured | BOOLEAN | Producto destacado |
| created_at | TIMESTAMP | Fecha de creación |
| updated_at | TIMESTAMP | Fecha de última actualización |

**Relaciones**:
- `store_id` → `stores(id)` con CASCADE DELETE
- `category_id` → `product_categories(id)`

### 5. orders
**Descripción**: Pedidos realizados por los clientes.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| customer_id | UUID (FK) | Referencia al cliente |
| store_id | UUID (FK) | Referencia al colmado |
| delivery_person_id | UUID (FK) | Referencia al repartidor |
| order_number | TEXT | Número de pedido legible |
| status | order_status | Estado del pedido |
| subtotal | DECIMAL(10,2) | Subtotal del pedido |
| delivery_fee | DECIMAL(10,2) | Tarifa de entrega |
| priority_fee | DECIMAL(10,2) | Tarifa por entrega prioritaria |
| total_amount | DECIMAL(10,2) | Monto total |
| payment_method | payment_method | Método de pago |
| is_priority | BOOLEAN | Entrega prioritaria |
| delivery_address | TEXT | Dirección de entrega |
| delivery_location | GEOGRAPHY(POINT) | Coordenadas de entrega |
| customer_notes | TEXT | Notas del cliente |
| estimated_delivery_time | TIMESTAMP | Tiempo estimado de entrega |
| delivered_at | TIMESTAMP | Fecha de entrega |
| created_at | TIMESTAMP | Fecha de creación |
| updated_at | TIMESTAMP | Fecha de última actualización |

**Relaciones**:
- `customer_id` → `users(id)` con CASCADE DELETE
- `store_id` → `stores(id)` con CASCADE DELETE
- `delivery_person_id` → `users(id)`

### 6. order_items
**Descripción**: Items individuales de cada pedido.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| order_id | UUID (FK) | Referencia al pedido |
| product_id | UUID (FK) | Referencia al producto |
| quantity | INTEGER | Cantidad solicitada |
| unit_price | DECIMAL(10,2) | Precio unitario |
| total_price | DECIMAL(10,2) | Precio total del item |
| created_at | TIMESTAMP | Fecha de creación |

**Relaciones**:
- `order_id` → `orders(id)` con CASCADE DELETE
- `product_id` → `products(id)` con CASCADE DELETE

### 7. deliveries
**Descripción**: Información de entregas y estado de repartidores.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| delivery_person_id | UUID (FK) | Referencia al repartidor |
| status | delivery_status | Estado del repartidor |
| current_location | GEOGRAPHY(POINT) | Ubicación actual |
| cash_on_hand | DECIMAL(10,2) | Efectivo disponible |
| total_orders_today | INTEGER | Pedidos entregados hoy |
| earnings_today | DECIMAL(10,2) | Ganancias del día |
| started_shift_at | TIMESTAMP | Inicio de turno |
| ended_shift_at | TIMESTAMP | Fin de turno |
| created_at | TIMESTAMP | Fecha de creación |
| updated_at | TIMESTAMP | Fecha de última actualización |

**Relaciones**:
- `delivery_person_id` → `users(id)` con CASCADE DELETE

### 8. delivery_routes
**Descripción**: Rutas optimizadas para entregas.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| delivery_person_id | UUID (FK) | Referencia al repartidor |
| route_data | JSONB | Datos de la ruta optimizada |
| total_distance | DECIMAL(10,2) | Distancia total en km |
| estimated_time | INTEGER | Tiempo estimado en minutos |
| is_active | BOOLEAN | Estado activo de la ruta |
| created_at | TIMESTAMP | Fecha de creación |

**Relaciones**:
- `delivery_person_id` → `users(id)` con CASCADE DELETE

### 9. route_orders
**Descripción**: Asignación de pedidos a rutas específicas.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| route_id | UUID (FK) | Referencia a la ruta |
| order_id | UUID (FK) | Referencia al pedido |
| sequence_number | INTEGER | Orden en la ruta |
| is_completed | BOOLEAN | Estado de completado |
| completed_at | TIMESTAMP | Fecha de completado |
| created_at | TIMESTAMP | Fecha de creación |

**Relaciones**:
- `route_id` → `delivery_routes(id)` con CASCADE DELETE
- `order_id` → `orders(id)` con CASCADE DELETE

### 10. subscriptions
**Descripción**: Suscripciones de usuarios y colmados.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| user_id | UUID (FK) | Referencia al usuario |
| store_id | UUID (FK) | Referencia al colmado (opcional) |
| subscription_type | TEXT | Tipo de suscripción |
| amount | DECIMAL(10,2) | Monto de la suscripción |
| is_active | BOOLEAN | Estado activo |
| starts_at | TIMESTAMP | Fecha de inicio |
| ends_at | TIMESTAMP | Fecha de fin |
| created_at | TIMESTAMP | Fecha de creación |

**Relaciones**:
- `user_id` → `users(id)` con CASCADE DELETE
- `store_id` → `stores(id)` con CASCADE DELETE

### 11. reviews
**Descripción**: Reseñas y calificaciones de colmados.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| customer_id | UUID (FK) | Referencia al cliente |
| store_id | UUID (FK) | Referencia al colmado |
| order_id | UUID (FK) | Referencia al pedido |
| rating | INTEGER | Calificación (1-5) |
| comment | TEXT | Comentario |
| created_at | TIMESTAMP | Fecha de creación |

**Relaciones**:
- `customer_id` → `users(id)` con CASCADE DELETE
- `store_id` → `stores(id)` con CASCADE DELETE
- `order_id` → `orders(id)` con CASCADE DELETE

### 12. promotions
**Descripción**: Ofertas y promociones de los colmados.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| store_id | UUID (FK) | Referencia al colmado |
| title | TEXT | Título de la promoción |
| description | TEXT | Descripción |
| discount_type | TEXT | Tipo de descuento (percentage/fixed_amount) |
| discount_value | DECIMAL(10,2) | Valor del descuento |
| min_order_amount | DECIMAL(10,2) | Monto mínimo de pedido |
| max_discount_amount | DECIMAL(10,2) | Descuento máximo |
| is_active | BOOLEAN | Estado activo |
| starts_at | TIMESTAMP | Fecha de inicio |
| ends_at | TIMESTAMP | Fecha de fin |
| created_at | TIMESTAMP | Fecha de creación |

**Relaciones**:
- `store_id` → `stores(id)` con CASCADE DELETE

### 13. notifications
**Descripción**: Sistema de notificaciones para usuarios.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | UUID (PK) | Identificador único |
| user_id | UUID (FK) | Referencia al usuario |
| title | TEXT | Título de la notificación |
| message | TEXT | Mensaje |
| type | TEXT | Tipo (info, success, warning, error) |
| is_read | BOOLEAN | Estado de lectura |
| data | JSONB | Datos adicionales |
| created_at | TIMESTAMP | Fecha de creación |

**Relaciones**:
- `user_id` → `users(id)` con CASCADE DELETE

## Índices para Optimización

```sql
-- Índices geográficos
CREATE INDEX idx_stores_location ON public.stores USING GIST (location);

-- Índices de relaciones
CREATE INDEX idx_stores_owner_id ON public.stores (owner_id);
CREATE INDEX idx_products_store_id ON public.products (store_id);
CREATE INDEX idx_products_category_id ON public.products (category_id);
CREATE INDEX idx_orders_customer_id ON public.orders (customer_id);
CREATE INDEX idx_orders_store_id ON public.orders (store_id);
CREATE INDEX idx_orders_delivery_person_id ON public.orders (delivery_person_id);
CREATE INDEX idx_order_items_order_id ON public.order_items (order_id);
CREATE INDEX idx_order_items_product_id ON public.order_items (product_id);
CREATE INDEX idx_deliveries_delivery_person_id ON public.deliveries (delivery_person_id);

-- Índices de estado y filtros
CREATE INDEX idx_stores_is_active ON public.stores (is_active);
CREATE INDEX idx_products_is_active ON public.products (is_active);
CREATE INDEX idx_orders_status ON public.orders (status);
CREATE INDEX idx_orders_created_at ON public.orders (created_at);
CREATE INDEX idx_deliveries_status ON public.deliveries (status);
CREATE INDEX idx_notifications_user_id ON public.notifications (user_id);
CREATE INDEX idx_notifications_is_read ON public.notifications (is_read);
```

## Triggers Automáticos

### Función para actualizar updated_at
```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';
```

### Triggers aplicados
- `users` - Actualiza `updated_at` en UPDATE
- `stores` - Actualiza `updated_at` en UPDATE
- `products` - Actualiza `updated_at` en UPDATE
- `orders` - Actualiza `updated_at` en UPDATE
- `deliveries` - Actualiza `updated_at` en UPDATE

## Políticas de Seguridad (RLS)

### Principios de Seguridad
1. **Usuarios**: Solo pueden ver y modificar su propio perfil
2. **Colmados**: Los dueños solo pueden gestionar sus propios colmados
3. **Productos**: Solo los dueños pueden gestionar productos de sus colmados
4. **Pedidos**: Acceso basado en rol (cliente, dueño, repartidor)
5. **Entregas**: Solo repartidores pueden gestionar sus entregas
6. **Notificaciones**: Solo el usuario puede ver sus notificaciones

### Políticas Principales

#### Usuarios
- Ver perfil propio: `auth.uid() = id`
- Ver perfiles públicos: `true` (para mostrar repartidores/dueños)
- Actualizar perfil: `auth.uid() = id`

#### Colmados
- Ver colmados activos: `is_active = true`
- Gestionar colmado: `auth.uid() = owner_id AND role = 'dueno'`

#### Pedidos
- Cliente ve sus pedidos: `auth.uid() = customer_id`
- Dueño ve pedidos de su colmado: `store.owner_id = auth.uid()`
- Repartidor ve pedidos asignados: `auth.uid() = delivery_person_id`

## Funciones Edge (Supabase Functions)

### optimize-delivery-route
**Descripción**: Función para optimizar rutas de entrega usando algoritmo del vecino más cercano.

**Características**:
- Prioriza pedidos marcados como prioritarios
- Calcula distancias usando fórmula de Haversine
- Estima tiempo de entrega (30 km/h + 5 min por entrega)
- Guarda ruta optimizada en `delivery_routes`
- Crea registros en `route_orders` con secuencia

**Parámetros**:
```typescript
{
  deliveryPersonId: string,
  orderIds: string[],
  startLocation: { latitude: number, longitude: number }
}
```

**Respuesta**:
```typescript
{
  success: boolean,
  routeId: string,
  optimizedRoute: {
    totalDistance: number,
    estimatedTime: number,
    orderedPoints: DeliveryPoint[],
    routeData: any
  }
}
```

## Diagrama de Relaciones

```
auth.users (Supabase)
    ↓
  users
    ├── stores (owner_id)
    │   ├── products
    │   ├── orders (store_id)
    │   ├── reviews (store_id)
    │   ├── promotions
    │   └── subscriptions (store_id)
    ├── orders (customer_id, delivery_person_id)
    │   └── order_items
    ├── deliveries (delivery_person_id)
    ├── delivery_routes (delivery_person_id)
    │   └── route_orders
    ├── subscriptions (user_id)
    ├── reviews (customer_id)
    └── notifications (user_id)

product_categories
    └── products (category_id)
```

## Consideraciones Técnicas

### Geolocalización
- Uso de PostGIS para manejo de coordenadas geográficas
- Formato: `GEOGRAPHY(POINT, 4326)` (WGS84)
- Índices GIST para consultas espaciales eficientes

### Escalabilidad
- UUIDs como claves primarias para distribución
- Índices optimizados para consultas frecuentes
- Particionamiento potencial por fecha en `orders`

### Seguridad
- Row Level Security habilitado en todas las tablas
- Políticas granulares basadas en roles
- Validación de datos a nivel de base de datos

### Monitoreo
- Campos `created_at` y `updated_at` en tablas principales
- Triggers automáticos para auditoría
- Campos de estado para soft deletes

Esta estructura proporciona una base sólida para una aplicación de delivery de colmados, con capacidades de geolocalización, optimización de rutas, y un sistema robusto de seguridad y permisos.