import '../entities/subscription.dart';

/// Repositorio abstracto para la gestión de suscripciones
/// Define los contratos que debe implementar la capa de datos
abstract class SubscriptionRepository {
  /// Obtiene todas las suscripciones
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir para paginación
  Future<List<Subscription>> getAllSubscriptions({int limit = 50, int offset = 0});
  
  /// Obtiene una suscripción por su ID
  /// Lanza excepción si la suscripción no existe
  Future<Subscription> getSubscriptionById(String subscriptionId);
  
  /// Obtiene múltiples suscripciones por sus IDs
  Future<List<Subscription>> getSubscriptionsByIds(List<String> subscriptionIds);
  
  /// Obtiene suscripciones de un usuario específico
  /// [userId] - ID del usuario
  /// [status] - Filtrar por estado (opcional)
  /// [type] - Filtrar por tipo (opcional)
  Future<List<Subscription>> getSubscriptionsByUser(
    String userId, {
    SubscriptionStatus? status,
    SubscriptionType? type,
  });
  
  /// Obtiene la suscripción activa de un usuario
  /// [userId] - ID del usuario
  /// [type] - Tipo de suscripción (opcional)
  Future<Subscription?> getActiveSubscriptionByUser(
    String userId, {
    SubscriptionType? type,
  });
  
  /// Obtiene suscripciones por estado
  /// [status] - Estado a filtrar
  /// [type] - Tipo de suscripción (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Subscription>> getSubscriptionsByStatus(
    SubscriptionStatus status, {
    SubscriptionType? type,
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene suscripciones por tipo
  /// [type] - Tipo a filtrar
  /// [status] - Estado de suscripción (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Subscription>> getSubscriptionsByType(
    SubscriptionType type, {
    SubscriptionStatus? status,
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene suscripciones que expiran pronto
  /// [daysAhead] - Número de días hacia adelante para buscar
  /// [type] - Tipo de suscripción (opcional)
  Future<List<Subscription>> getExpiringSubscriptions(
    int daysAhead, {
    SubscriptionType? type,
  });
  
  /// Obtiene suscripciones vencidas
  /// [type] - Tipo de suscripción (opcional)
  Future<List<Subscription>> getExpiredSubscriptions({
    SubscriptionType? type,
  });
  
  /// Crea una nueva suscripción
  /// [subscription] - Datos de la suscripción a crear
  Future<Subscription> createSubscription(Subscription subscription);
  
  /// Actualiza una suscripción existente
  /// [subscriptionId] - ID de la suscripción a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<Subscription> updateSubscription(
    String subscriptionId,
    Map<String, dynamic> updates,
  );
  
  /// Actualiza el estado de una suscripción
  /// [subscriptionId] - ID de la suscripción
  /// [newStatus] - Nuevo estado
  /// [updatedBy] - ID del usuario que actualiza
  /// [notes] - Notas adicionales (opcional)
  Future<Subscription> updateSubscriptionStatus(
    String subscriptionId,
    SubscriptionStatus newStatus,
    String updatedBy, {
    String? notes,
  });
  
  /// Renueva una suscripción
  /// [subscriptionId] - ID de la suscripción
  /// [newEndDate] - Nueva fecha de finalización
  /// [paymentId] - ID del pago de renovación (opcional)
  Future<Subscription> renewSubscription(
    String subscriptionId,
    DateTime newEndDate, {
    String? paymentId,
  });
  
  /// Cancela una suscripción
  /// [subscriptionId] - ID de la suscripción
  /// [cancelledBy] - ID del usuario que cancela
  /// [reason] - Razón de la cancelación
  /// [immediateCancel] - Si debe cancelarse inmediatamente o al final del período
  Future<Subscription> cancelSubscription(
    String subscriptionId,
    String cancelledBy,
    String reason, {
    bool immediateCancel = false,
  });
  
  /// Reactiva una suscripción cancelada
  /// [subscriptionId] - ID de la suscripción
  /// [reactivatedBy] - ID del usuario que reactiva
  /// [newEndDate] - Nueva fecha de finalización
  Future<Subscription> reactivateSubscription(
    String subscriptionId,
    String reactivatedBy,
    DateTime newEndDate,
  );
  
  /// Actualiza la configuración de auto-renovación
  /// [subscriptionId] - ID de la suscripción
  /// [autoRenew] - Nuevo valor de auto-renovación
  Future<Subscription> updateAutoRenewal(String subscriptionId, bool autoRenew);
  
  /// Actualiza el precio de una suscripción
  /// [subscriptionId] - ID de la suscripción
  /// [newPrice] - Nuevo precio
  /// [effectiveDate] - Fecha efectiva del cambio
  Future<Subscription> updateSubscriptionPrice(
    String subscriptionId,
    double newPrice,
    DateTime effectiveDate,
  );
  
  /// Actualiza las notas de una suscripción
  /// [subscriptionId] - ID de la suscripción
  /// [notes] - Nuevas notas
  Future<Subscription> updateSubscriptionNotes(
    String subscriptionId,
    String notes,
  );
  
  /// Obtiene el historial de una suscripción
  /// [subscriptionId] - ID de la suscripción
  Future<List<Map<String, dynamic>>> getSubscriptionHistory(String subscriptionId);
  
  /// Obtiene estadísticas de suscripciones
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [type] - Tipo de suscripción (opcional)
  Future<Map<String, dynamic>> getSubscriptionStats(
    DateTime startDate,
    DateTime endDate, {
    SubscriptionType? type,
  });
  
  /// Obtiene estadísticas de ingresos por suscripciones
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [type] - Tipo de suscripción (opcional)
  Future<Map<String, dynamic>> getSubscriptionRevenueStats(
    DateTime startDate,
    DateTime endDate, {
    SubscriptionType? type,
  });
  
  /// Obtiene el total de ingresos por suscripciones
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [type] - Tipo de suscripción (opcional)
  Future<double> getTotalSubscriptionRevenue(
    DateTime startDate,
    DateTime endDate, {
    SubscriptionType? type,
  });
  
  /// Obtiene el conteo total de suscripciones
  Future<int> getTotalSubscriptionsCount();
  
  /// Obtiene el conteo de suscripciones activas
  /// [type] - Tipo de suscripción (opcional)
  Future<int> getActiveSubscriptionsCount({SubscriptionType? type});
  
  /// Obtiene el conteo de suscripciones por estado
  /// [status] - Estado a contar
  /// [type] - Tipo de suscripción (opcional)
  Future<int> getSubscriptionsCountByStatus(
    SubscriptionStatus status, {
    SubscriptionType? type,
  });
  
  /// Obtiene el conteo de nuevas suscripciones en un período
  /// [startDate] - Fecha de inicio
  /// [endDate] - Fecha de fin
  /// [type] - Tipo de suscripción (opcional)
  Future<int> getNewSubscriptionsCount(
    DateTime startDate,
    DateTime endDate, {
    SubscriptionType? type,
  });
  
  /// Verifica si un usuario tiene una suscripción activa
  /// [userId] - ID del usuario
  /// [type] - Tipo de suscripción (opcional)
  Future<bool> hasActiveSubscription(
    String userId, {
    SubscriptionType? type,
  });
  
  /// Obtiene la fecha de expiración de la suscripción activa de un usuario
  /// [userId] - ID del usuario
  /// [type] - Tipo de suscripción (opcional)
  Future<DateTime?> getSubscriptionExpirationDate(
    String userId, {
    SubscriptionType? type,
  });
  
  /// Procesa renovaciones automáticas
  /// Busca suscripciones que deben renovarse automáticamente
  Future<List<Subscription>> processAutoRenewals();
  
  /// Procesa expiraciones de suscripciones
  /// Actualiza el estado de suscripciones vencidas
  Future<List<Subscription>> processExpiredSubscriptions();
  
  /// Elimina una suscripción (soft delete)
  /// [subscriptionId] - ID de la suscripción a eliminar
  Future<void> deleteSubscription(String subscriptionId);
  
  /// Restaura una suscripción eliminada
  /// [subscriptionId] - ID de la suscripción a restaurar
  Future<Subscription> restoreSubscription(String subscriptionId);
}

/// Repositorio abstracto para la gestión de pagos de suscripciones
abstract class SubscriptionPaymentRepository {
  /// Obtiene todos los pagos de suscripciones
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<SubscriptionPayment>> getAllPayments({
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene un pago por su ID
  Future<SubscriptionPayment> getPaymentById(String paymentId);
  
  /// Obtiene pagos de una suscripción específica
  /// [subscriptionId] - ID de la suscripción
  /// [isSuccessful] - Filtrar por éxito (opcional)
  Future<List<SubscriptionPayment>> getPaymentsBySubscription(
    String subscriptionId, {
    bool? isSuccessful,
  });
  
  /// Obtiene pagos por método de pago
  /// [paymentMethod] - Método de pago a filtrar
  /// [isSuccessful] - Filtrar por éxito (opcional)
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  Future<List<SubscriptionPayment>> getPaymentsByMethod(
    String paymentMethod, {
    bool? isSuccessful,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Obtiene pagos fallidos
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  Future<List<SubscriptionPayment>> getFailedPayments({
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Crea un nuevo pago de suscripción
  /// [payment] - Datos del pago a crear
  Future<SubscriptionPayment> createPayment(SubscriptionPayment payment);
  
  /// Actualiza un pago existente
  /// [paymentId] - ID del pago a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<SubscriptionPayment> updatePayment(
    String paymentId,
    Map<String, dynamic> updates,
  );
  
  /// Marca un pago como exitoso
  /// [paymentId] - ID del pago
  /// [transactionId] - ID de la transacción
  /// [processedDate] - Fecha de procesamiento
  Future<SubscriptionPayment> markPaymentAsSuccessful(
    String paymentId,
    String transactionId,
    DateTime processedDate,
  );
  
  /// Marca un pago como fallido
  /// [paymentId] - ID del pago
  /// [failureReason] - Razón del fallo
  Future<SubscriptionPayment> markPaymentAsFailed(
    String paymentId,
    String failureReason,
  );
  
  /// Obtiene estadísticas de pagos
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getPaymentStats(
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Obtiene el total de ingresos por pagos
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [isSuccessful] - Solo pagos exitosos (por defecto true)
  Future<double> getTotalPaymentAmount(
    DateTime startDate,
    DateTime endDate, {
    bool isSuccessful = true,
  });
  
  /// Obtiene el conteo de pagos
  /// [isSuccessful] - Filtrar por éxito (opcional)
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  Future<int> getPaymentsCount({
    bool? isSuccessful,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Obtiene la tasa de éxito de pagos
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<double> getPaymentSuccessRate(
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Elimina un pago (soft delete)
  /// [paymentId] - ID del pago a eliminar
  Future<void> deletePayment(String paymentId);
  
  /// Restaura un pago eliminado
  /// [paymentId] - ID del pago a restaurar
  Future<SubscriptionPayment> restorePayment(String paymentId);
}