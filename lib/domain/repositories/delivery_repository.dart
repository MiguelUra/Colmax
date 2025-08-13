import '../entities/delivery.dart';
import '../entities/order.dart';
import '../entities/user.dart';

/// Repositorio abstracto para la gestión de entregas
/// Define los contratos que debe implementar la capa de datos
abstract class DeliveryRepository {
  /// Obtiene todas las entregas
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir para paginación
  Future<List<Delivery>> getAllDeliveries({int limit = 50, int offset = 0});
  
  /// Obtiene una entrega por su ID
  /// Lanza excepción si la entrega no existe
  Future<Delivery> getDeliveryById(String deliveryId);
  
  /// Obtiene múltiples entregas por sus IDs
  Future<List<Delivery>> getDeliveriesByIds(List<String> deliveryIds);
  
  /// Obtiene la entrega asociada a un pedido
  /// [orderId] - ID del pedido
  Future<Delivery?> getDeliveryByOrderId(String orderId);
  
  /// Obtiene entregas asignadas a un repartidor
  /// [deliveryPersonId] - ID del repartidor
  /// [status] - Filtrar por estado (opcional)
  /// [date] - Filtrar por fecha específica (opcional)
  Future<List<Delivery>> getDeliveriesByDeliveryPerson(
    String deliveryPersonId, {
    DeliveryStatus? status,
    DateTime? date,
  });
  
  /// Obtiene entregas por estado
  /// [status] - Estado a filtrar
  /// [deliveryPersonId] - ID del repartidor (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Delivery>> getDeliveriesByStatus(
    DeliveryStatus status, {
    String? deliveryPersonId,
    int limit = 50,
  });
  
  /// Obtiene entregas pendientes de asignación
  Future<List<Delivery>> getPendingDeliveries();
  
  /// Obtiene entregas en progreso
  /// [deliveryPersonId] - ID del repartidor (opcional)
  Future<List<Delivery>> getActiveDeliveries({String? deliveryPersonId});
  
  /// Obtiene entregas completadas
  /// [deliveryPersonId] - ID del repartidor (opcional)
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  Future<List<Delivery>> getCompletedDeliveries({
    String? deliveryPersonId,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Crea una nueva entrega
  /// [delivery] - Datos de la entrega a crear
  Future<Delivery> createDelivery(Delivery delivery);
  
  /// Actualiza una entrega existente
  /// [deliveryId] - ID de la entrega a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<Delivery> updateDelivery(String deliveryId, Map<String, dynamic> updates);
  
  /// Actualiza el estado de una entrega
  /// [deliveryId] - ID de la entrega
  /// [newStatus] - Nuevo estado
  /// [updatedBy] - ID del usuario que actualiza
  /// [notes] - Notas adicionales (opcional)
  Future<Delivery> updateDeliveryStatus(
    String deliveryId,
    DeliveryStatus newStatus,
    String updatedBy, {
    String? notes,
  });
  
  /// Asigna un repartidor a una entrega
  /// [deliveryId] - ID de la entrega
  /// [deliveryPersonId] - ID del repartidor
  /// [estimatedTime] - Tiempo estimado de entrega
  Future<Delivery> assignDeliveryPerson(
    String deliveryId,
    String deliveryPersonId,
    DateTime estimatedTime,
  );
  
  /// Remueve la asignación de repartidor de una entrega
  /// [deliveryId] - ID de la entrega
  Future<Delivery> unassignDeliveryPerson(String deliveryId);
  
  /// Actualiza la ubicación de recogida
  /// [deliveryId] - ID de la entrega
  /// [address] - Nueva dirección
  /// [latitude] - Nueva latitud
  /// [longitude] - Nueva longitud
  Future<Delivery> updatePickupLocation(
    String deliveryId,
    String address,
    double latitude,
    double longitude,
  );
  
  /// Actualiza la ubicación de entrega
  /// [deliveryId] - ID de la entrega
  /// [address] - Nueva dirección
  /// [latitude] - Nueva latitud
  /// [longitude] - Nueva longitud
  Future<Delivery> updateDeliveryLocation(
    String deliveryId,
    String address,
    double latitude,
    double longitude,
  );
  
  /// Actualiza la distancia estimada
  /// [deliveryId] - ID de la entrega
  /// [distance] - Nueva distancia en kilómetros
  Future<Delivery> updateEstimatedDistance(String deliveryId, double distance);
  
  /// Actualiza el tiempo estimado de entrega
  /// [deliveryId] - ID de la entrega
  /// [estimatedTime] - Nuevo tiempo estimado
  Future<Delivery> updateEstimatedTime(String deliveryId, DateTime estimatedTime);
  
  /// Actualiza las notas de una entrega
  /// [deliveryId] - ID de la entrega
  /// [notes] - Nuevas notas
  Future<Delivery> updateDeliveryNotes(String deliveryId, String notes);
  
  /// Inicia una entrega (repartidor recoge el pedido)
  /// [deliveryId] - ID de la entrega
  /// [deliveryPersonId] - ID del repartidor
  Future<Delivery> startDelivery(String deliveryId, String deliveryPersonId);
  
  /// Completa una entrega
  /// [deliveryId] - ID de la entrega
  /// [deliveryPersonId] - ID del repartidor
  /// [deliveryNotes] - Notas de entrega (opcional)
  Future<Delivery> completeDelivery(
    String deliveryId,
    String deliveryPersonId, {
    String? deliveryNotes,
  });
  
  /// Cancela una entrega
  /// [deliveryId] - ID de la entrega
  /// [cancelledBy] - ID del usuario que cancela
  /// [reason] - Razón de la cancelación
  Future<Delivery> cancelDelivery(
    String deliveryId,
    String cancelledBy,
    String reason,
  );
  
  /// Obtiene el historial de estados de una entrega
  /// [deliveryId] - ID de la entrega
  Future<List<Map<String, dynamic>>> getDeliveryStatusHistory(String deliveryId);
  
  /// Obtiene estadísticas de entregas
  /// [deliveryPersonId] - ID del repartidor (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getDeliveryStats(
    DateTime startDate,
    DateTime endDate, {
    String? deliveryPersonId,
  });
  
  /// Obtiene el tiempo promedio de entrega
  /// [deliveryPersonId] - ID del repartidor (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Duration> getAverageDeliveryTime(
    DateTime startDate,
    DateTime endDate, {
    String? deliveryPersonId,
  });
  
  /// Obtiene entregas con retraso
  /// [deliveryPersonId] - ID del repartidor (opcional)
  Future<List<Delivery>> getDelayedDeliveries({String? deliveryPersonId});
  
  /// Obtiene el conteo total de entregas
  Future<int> getTotalDeliveriesCount();
  
  /// Obtiene el conteo de entregas por estado
  /// [status] - Estado a contar
  /// [deliveryPersonId] - ID del repartidor (opcional)
  Future<int> getDeliveriesCountByStatus(
    DeliveryStatus status, {
    String? deliveryPersonId,
  });
  
  /// Obtiene el conteo de entregas de hoy
  /// [deliveryPersonId] - ID del repartidor (opcional)
  Future<int> getTodayDeliveriesCount({String? deliveryPersonId});
  
  /// Elimina una entrega (soft delete)
  /// [deliveryId] - ID de la entrega a eliminar
  Future<void> deleteDelivery(String deliveryId);
  
  /// Restaura una entrega eliminada
  /// [deliveryId] - ID de la entrega a restaurar
  Future<Delivery> restoreDelivery(String deliveryId);
}

/// Repositorio abstracto para la gestión de rutas de entrega
abstract class DeliveryRouteRepository {
  /// Obtiene todas las rutas de entrega
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<DeliveryRoute>> getAllRoutes({int limit = 50, int offset = 0});
  
  /// Obtiene una ruta por su ID
  Future<DeliveryRoute> getRouteById(String routeId);
  
  /// Obtiene rutas asignadas a un repartidor
  /// [deliveryPersonId] - ID del repartidor
  /// [isActive] - Filtrar por estado activo (opcional)
  /// [date] - Filtrar por fecha específica (opcional)
  Future<List<DeliveryRoute>> getRoutesByDeliveryPerson(
    String deliveryPersonId, {
    bool? isActive,
    DateTime? date,
  });
  
  /// Obtiene la ruta activa de un repartidor
  /// [deliveryPersonId] - ID del repartidor
  Future<DeliveryRoute?> getActiveRouteByDeliveryPerson(String deliveryPersonId);
  
  /// Crea una nueva ruta de entrega
  /// [route] - Datos de la ruta a crear
  Future<DeliveryRoute> createRoute(DeliveryRoute route);
  
  /// Actualiza una ruta existente
  /// [routeId] - ID de la ruta a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<DeliveryRoute> updateRoute(String routeId, Map<String, dynamic> updates);
  
  /// Agrega un pedido a una ruta
  /// [routeId] - ID de la ruta
  /// [orderId] - ID del pedido
  /// [sequence] - Secuencia en la ruta
  Future<DeliveryRoute> addOrderToRoute(
    String routeId,
    String orderId,
    int sequence,
  );
  
  /// Remueve un pedido de una ruta
  /// [routeId] - ID de la ruta
  /// [orderId] - ID del pedido
  Future<DeliveryRoute> removeOrderFromRoute(String routeId, String orderId);
  
  /// Reordena los pedidos en una ruta
  /// [routeId] - ID de la ruta
  /// [orderSequences] - Mapa de orderId -> secuencia
  Future<DeliveryRoute> reorderRoute(
    String routeId,
    Map<String, int> orderSequences,
  );
  
  /// Optimiza una ruta de entrega
  /// [routeId] - ID de la ruta
  Future<DeliveryRoute> optimizeRoute(String routeId);
  
  /// Activa una ruta
  /// [routeId] - ID de la ruta
  Future<DeliveryRoute> activateRoute(String routeId);
  
  /// Desactiva una ruta
  /// [routeId] - ID de la ruta
  Future<DeliveryRoute> deactivateRoute(String routeId);
  
  /// Completa una ruta
  /// [routeId] - ID de la ruta
  Future<DeliveryRoute> completeRoute(String routeId);
  
  /// Obtiene estadísticas de rutas
  /// [deliveryPersonId] - ID del repartidor (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getRouteStats(
    DateTime startDate,
    DateTime endDate, {
    String? deliveryPersonId,
  });
  
  /// Elimina una ruta
  /// [routeId] - ID de la ruta a eliminar
  Future<void> deleteRoute(String routeId);
}

/// Repositorio abstracto para el seguimiento de ubicación de repartidores
abstract class DeliveryPersonLocationRepository {
  /// Obtiene la ubicación actual de un repartidor
  /// [deliveryPersonId] - ID del repartidor
  Future<DeliveryPersonLocation?> getCurrentLocation(String deliveryPersonId);
  
  /// Actualiza la ubicación de un repartidor
  /// [location] - Nueva ubicación
  Future<DeliveryPersonLocation> updateLocation(DeliveryPersonLocation location);
  
  /// Obtiene el historial de ubicaciones de un repartidor
  /// [deliveryPersonId] - ID del repartidor
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [limit] - Número máximo de resultados
  Future<List<DeliveryPersonLocation>> getLocationHistory(
    String deliveryPersonId,
    DateTime startDate,
    DateTime endDate, {
    int limit = 100,
  });
  
  /// Obtiene repartidores cercanos a una ubicación
  /// [latitude] - Latitud de referencia
  /// [longitude] - Longitud de referencia
  /// [radiusKm] - Radio de búsqueda en kilómetros
  /// [isAvailable] - Filtrar por disponibilidad (opcional)
  Future<List<Map<String, dynamic>>> getNearbyDeliveryPersons(
    double latitude,
    double longitude,
    double radiusKm, {
    bool? isAvailable,
  });
  
  /// Limpia ubicaciones antiguas
  /// [olderThanHours] - Eliminar ubicaciones más antiguas que X horas
  Future<void> cleanOldLocations(int olderThanHours);
  
  /// Obtiene la distancia recorrida por un repartidor
  /// [deliveryPersonId] - ID del repartidor
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<double> getDistanceTraveled(
    String deliveryPersonId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Obtiene el tiempo activo de un repartidor
  /// [deliveryPersonId] - ID del repartidor
  /// [date] - Fecha específica
  Future<Duration> getActiveTime(String deliveryPersonId, DateTime date);
}