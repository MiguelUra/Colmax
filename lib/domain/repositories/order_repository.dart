import '../entities/order.dart';
import '../entities/user.dart';

/// Repositorio abstracto para la gestión de pedidos
/// Define los contratos que debe implementar la capa de datos
abstract class OrderRepository {
  /// Obtiene todos los pedidos
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir para paginación
  Future<List<Order>> getAllOrders({int limit = 50, int offset = 0});
  
  /// Obtiene un pedido por su ID
  /// Lanza excepción si el pedido no existe
  Future<Order> getOrderById(String orderId);
  
  /// Obtiene múltiples pedidos por sus IDs
  Future<List<Order>> getOrdersByIds(List<String> orderIds);
  
  /// Obtiene pedidos de un cliente específico
  /// [customerId] - ID del cliente
  /// [status] - Filtrar por estado (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Order>> getOrdersByCustomer(
    String customerId, {
    OrderStatus? status,
    int limit = 20,
    int offset = 0,
  });
  
  /// Obtiene pedidos de una tienda específica
  /// [storeId] - ID de la tienda
  /// [status] - Filtrar por estado (opcional)
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Order>> getOrdersByStore(
    String storeId, {
    OrderStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene pedidos asignados a un repartidor
  /// [deliveryPersonId] - ID del repartidor
  /// [status] - Filtrar por estado (opcional)
  /// [date] - Filtrar por fecha específica (opcional)
  Future<List<Order>> getOrdersByDeliveryPerson(
    String deliveryPersonId, {
    OrderStatus? status,
    DateTime? date,
  });
  
  /// Obtiene pedidos por estado
  /// [status] - Estado a filtrar
  /// [storeId] - ID de la tienda (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Order>> getOrdersByStatus(
    OrderStatus status, {
    String? storeId,
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene pedidos pendientes de asignación
  /// [storeId] - ID de la tienda (opcional)
  Future<List<Order>> getPendingOrders({String? storeId});
  
  /// Obtiene pedidos en preparación
  /// [storeId] - ID de la tienda (opcional)
  Future<List<Order>> getOrdersInPreparation({String? storeId});
  
  /// Obtiene pedidos listos para entrega
  /// [storeId] - ID de la tienda (opcional)
  Future<List<Order>> getOrdersReadyForDelivery({String? storeId});
  
  /// Obtiene pedidos en camino
  /// [deliveryPersonId] - ID del repartidor (opcional)
  Future<List<Order>> getOrdersInTransit({String? deliveryPersonId});
  
  /// Crea un nuevo pedido
  /// [order] - Datos del pedido a crear
  Future<Order> createOrder(Order order);
  
  /// Actualiza un pedido existente
  /// [orderId] - ID del pedido a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<Order> updateOrder(String orderId, Map<String, dynamic> updates);
  
  /// Actualiza el estado de un pedido
  /// [orderId] - ID del pedido
  /// [newStatus] - Nuevo estado
  /// [updatedBy] - ID del usuario que actualiza
  /// [notes] - Notas adicionales (opcional)
  Future<Order> updateOrderStatus(
    String orderId,
    OrderStatus newStatus,
    String updatedBy, {
    String? notes,
  });
  
  /// Asigna un repartidor a un pedido
  /// [orderId] - ID del pedido
  /// [deliveryPersonId] - ID del repartidor
  /// [estimatedDeliveryTime] - Tiempo estimado de entrega
  Future<Order> assignDeliveryPerson(
    String orderId,
    String deliveryPersonId,
    DateTime estimatedDeliveryTime,
  );
  
  /// Remueve la asignación de repartidor de un pedido
  /// [orderId] - ID del pedido
  Future<Order> unassignDeliveryPerson(String orderId);
  
  /// Actualiza la dirección de entrega de un pedido
  /// [orderId] - ID del pedido
  /// [newAddress] - Nueva dirección
  /// [latitude] - Nueva latitud
  /// [longitude] - Nueva longitud
  Future<Order> updateDeliveryAddress(
    String orderId,
    String newAddress,
    double latitude,
    double longitude,
  );
  
  /// Actualiza el tiempo estimado de entrega
  /// [orderId] - ID del pedido
  /// [estimatedTime] - Nuevo tiempo estimado
  Future<Order> updateEstimatedDeliveryTime(
    String orderId,
    DateTime estimatedTime,
  );
  
  /// Actualiza la prioridad de un pedido
  /// [orderId] - ID del pedido
  /// [priority] - Nueva prioridad
  Future<Order> updateOrderPriority(String orderId, int priority);
  
  /// Actualiza las notas de un pedido
  /// [orderId] - ID del pedido
  /// [notes] - Nuevas notas
  Future<Order> updateOrderNotes(String orderId, String notes);
  
  /// Cancela un pedido
  /// [orderId] - ID del pedido
  /// [cancelledBy] - ID del usuario que cancela
  /// [reason] - Razón de la cancelación
  Future<Order> cancelOrder(
    String orderId,
    String cancelledBy,
    String reason,
  );
  
  /// Confirma la entrega de un pedido
  /// [orderId] - ID del pedido
  /// [deliveredBy] - ID del repartidor
  /// [deliveryNotes] - Notas de entrega (opcional)
  Future<Order> confirmDelivery(
    String orderId,
    String deliveredBy, {
    String? deliveryNotes,
  });
  
  /// Marca un pedido como pagado
  /// [orderId] - ID del pedido
  /// [paymentMethod] - Método de pago utilizado
  /// [transactionId] - ID de la transacción (opcional)
  Future<Order> markOrderAsPaid(
    String orderId,
    PaymentMethod paymentMethod, {
    String? transactionId,
  });
  
  /// Obtiene el historial de estados de un pedido
  /// [orderId] - ID del pedido
  Future<List<Map<String, dynamic>>> getOrderStatusHistory(String orderId);
  
  /// Obtiene estadísticas de pedidos
  /// [storeId] - ID de la tienda (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getOrderStats(
    DateTime startDate,
    DateTime endDate, {
    String? storeId,
  });
  
  /// Obtiene estadísticas de pedidos por día
  /// [storeId] - ID de la tienda (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<List<Map<String, dynamic>>> getDailyOrderStats(
    DateTime startDate,
    DateTime endDate, {
    String? storeId,
  });
  
  /// Obtiene el total de ventas en un período
  /// [storeId] - ID de la tienda (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<double> getTotalSales(
    DateTime startDate,
    DateTime endDate, {
    String? storeId,
  });
  
  /// Obtiene el promedio de valor de pedidos
  /// [storeId] - ID de la tienda (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<double> getAverageOrderValue(
    DateTime startDate,
    DateTime endDate, {
    String? storeId,
  });
  
  /// Obtiene el tiempo promedio de entrega
  /// [storeId] - ID de la tienda (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Duration> getAverageDeliveryTime(
    DateTime startDate,
    DateTime endDate, {
    String? storeId,
  });
  
  /// Obtiene pedidos con retraso en la entrega
  /// [storeId] - ID de la tienda (opcional)
  Future<List<Order>> getDelayedOrders({String? storeId});
  
  /// Obtiene pedidos prioritarios
  /// [storeId] - ID de la tienda (opcional)
  Future<List<Order>> getPriorityOrders({String? storeId});
  
  /// Busca pedidos por número de orden o cliente
  /// [query] - Término de búsqueda
  /// [storeId] - ID de la tienda (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Order>> searchOrders(
    String query, {
    String? storeId,
    int limit = 20,
  });
  
  /// Obtiene pedidos recientes de un cliente
  /// [customerId] - ID del cliente
  /// [limit] - Número máximo de resultados
  Future<List<Order>> getRecentOrdersByCustomer(
    String customerId, {
    int limit = 5,
  });
  
  /// Obtiene el último pedido de un cliente en una tienda
  /// [customerId] - ID del cliente
  /// [storeId] - ID de la tienda
  Future<Order?> getLastOrderByCustomerAndStore(
    String customerId,
    String storeId,
  );
  
  /// Verifica si un cliente puede hacer un nuevo pedido
  /// [customerId] - ID del cliente
  /// [storeId] - ID de la tienda
  Future<bool> canCustomerPlaceOrder(String customerId, String storeId);
  
  /// Obtiene el conteo total de pedidos
  Future<int> getTotalOrdersCount();
  
  /// Obtiene el conteo de pedidos por estado
  /// [status] - Estado a contar
  /// [storeId] - ID de la tienda (opcional)
  Future<int> getOrdersCountByStatus(
    OrderStatus status, {
    String? storeId,
  });
  
  /// Obtiene el conteo de pedidos de hoy
  /// [storeId] - ID de la tienda (opcional)
  Future<int> getTodayOrdersCount({String? storeId});
  
  /// Obtiene el conteo de pedidos de esta semana
  /// [storeId] - ID de la tienda (opcional)
  Future<int> getThisWeekOrdersCount({String? storeId});
  
  /// Obtiene el conteo de pedidos de este mes
  /// [storeId] - ID de la tienda (opcional)
  Future<int> getThisMonthOrdersCount({String? storeId});
  
  /// Elimina un pedido (soft delete)
  /// [orderId] - ID del pedido a eliminar
  Future<void> deleteOrder(String orderId);
  
  /// Restaura un pedido eliminado
  /// [orderId] - ID del pedido a restaurar
  Future<Order> restoreOrder(String orderId);
  
  /// Obtiene pedidos que requieren atención
  /// [storeId] - ID de la tienda (opcional)
  Future<List<Order>> getOrdersRequiringAttention({String? storeId});
  
  /// Actualiza el rating de un pedido
  /// [orderId] - ID del pedido
  /// [rating] - Calificación (1-5)
  /// [review] - Comentario de la reseña (opcional)
  Future<Order> rateOrder(
    String orderId,
    int rating, {
    String? review,
  });
  
  /// Obtiene pedidos sin calificar de un cliente
  /// [customerId] - ID del cliente
  /// [limit] - Número máximo de resultados
  Future<List<Order>> getUnratedOrdersByCustomer(
    String customerId, {
    int limit = 10,
  });
}

/// Repositorio abstracto para la gestión de items de pedidos
abstract class OrderItemRepository {
  /// Obtiene todos los items de un pedido
  /// [orderId] - ID del pedido
  Future<List<OrderItem>> getOrderItems(String orderId);
  
  /// Obtiene un item de pedido por su ID
  Future<OrderItem> getOrderItemById(String itemId);
  
  /// Crea un nuevo item de pedido
  /// [orderItem] - Datos del item a crear
  Future<OrderItem> createOrderItem(OrderItem orderItem);
  
  /// Actualiza un item de pedido
  /// [itemId] - ID del item a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<OrderItem> updateOrderItem(
    String itemId,
    Map<String, dynamic> updates,
  );
  
  /// Actualiza la cantidad de un item
  /// [itemId] - ID del item
  /// [newQuantity] - Nueva cantidad
  Future<OrderItem> updateOrderItemQuantity(String itemId, int newQuantity);
  
  /// Elimina un item de pedido
  /// [itemId] - ID del item a eliminar
  Future<void> deleteOrderItem(String itemId);
  
  /// Obtiene el total de items de un pedido
  /// [orderId] - ID del pedido
  Future<int> getOrderItemsCount(String orderId);
  
  /// Obtiene el valor total de items de un pedido
  /// [orderId] - ID del pedido
  Future<double> getOrderItemsTotal(String orderId);
  
  /// Obtiene los productos más vendidos
  /// [storeId] - ID de la tienda (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [limit] - Número máximo de resultados
  Future<List<Map<String, dynamic>>> getTopSellingProducts(
    DateTime startDate,
    DateTime endDate, {
    String? storeId,
    int limit = 10,
  });
  
  /// Obtiene estadísticas de ventas por producto
  /// [productId] - ID del producto
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getProductSalesStats(
    String productId,
    DateTime startDate,
    DateTime endDate,
  );
}