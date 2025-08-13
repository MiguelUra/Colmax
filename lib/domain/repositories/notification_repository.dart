import '../entities/notification.dart';

/// Repositorio abstracto para la gestión de notificaciones
/// Define los contratos que debe implementar la capa de datos
abstract class NotificationRepository {
  /// Obtiene todas las notificaciones
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir para paginación
  Future<List<AppNotification>> getAllNotifications({
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene una notificación por su ID
  /// Lanza excepción si la notificación no existe
  Future<AppNotification> getNotificationById(String notificationId);
  
  /// Obtiene múltiples notificaciones por sus IDs
  Future<List<AppNotification>> getNotificationsByIds(List<String> notificationIds);
  
  /// Obtiene notificaciones de un usuario específico
  /// [userId] - ID del usuario
  /// [isRead] - Filtrar por estado de lectura (opcional)
  /// [type] - Filtrar por tipo (opcional)
  /// [priority] - Filtrar por prioridad (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<AppNotification>> getNotificationsByUser(
    String userId, {
    bool? isRead,
    NotificationType? type,
    NotificationPriority? priority,
    int limit = 20,
    int offset = 0,
  });
  
  /// Obtiene notificaciones no leídas de un usuario
  /// [userId] - ID del usuario
  /// [type] - Filtrar por tipo (opcional)
  /// [priority] - Filtrar por prioridad (opcional)
  Future<List<AppNotification>> getUnreadNotificationsByUser(
    String userId, {
    NotificationType? type,
    NotificationPriority? priority,
  });
  
  /// Obtiene notificaciones por tipo
  /// [type] - Tipo a filtrar
  /// [userId] - ID del usuario (opcional)
  /// [isRead] - Filtrar por estado de lectura (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<AppNotification>> getNotificationsByType(
    NotificationType type, {
    String? userId,
    bool? isRead,
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene notificaciones por prioridad
  /// [priority] - Prioridad a filtrar
  /// [userId] - ID del usuario (opcional)
  /// [isRead] - Filtrar por estado de lectura (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<AppNotification>> getNotificationsByPriority(
    NotificationPriority priority, {
    String? userId,
    bool? isRead,
    int limit = 50,
  });
  
  /// Obtiene notificaciones recientes
  /// [userId] - ID del usuario (opcional)
  /// [hours] - Número de horas hacia atrás (por defecto 24)
  /// [limit] - Número máximo de resultados
  Future<List<AppNotification>> getRecentNotifications({
    String? userId,
    int hours = 24,
    int limit = 20,
  });
  
  /// Crea una nueva notificación
  /// [notification] - Datos de la notificación a crear
  Future<AppNotification> createNotification(AppNotification notification);
  
  /// Crea múltiples notificaciones en lote
  /// [notifications] - Lista de notificaciones a crear
  Future<List<AppNotification>> createNotifications(
    List<AppNotification> notifications,
  );
  
  /// Actualiza una notificación existente
  /// [notificationId] - ID de la notificación a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<AppNotification> updateNotification(
    String notificationId,
    Map<String, dynamic> updates,
  );
  
  /// Marca una notificación como leída
  /// [notificationId] - ID de la notificación
  /// [readBy] - ID del usuario que la lee
  Future<AppNotification> markAsRead(String notificationId, String readBy);
  
  /// Marca múltiples notificaciones como leídas
  /// [notificationIds] - Lista de IDs de notificaciones
  /// [readBy] - ID del usuario que las lee
  Future<List<AppNotification>> markMultipleAsRead(
    List<String> notificationIds,
    String readBy,
  );
  
  /// Marca todas las notificaciones de un usuario como leídas
  /// [userId] - ID del usuario
  /// [type] - Tipo específico (opcional)
  Future<int> markAllAsReadByUser(
    String userId, {
    NotificationType? type,
  });
  
  /// Marca una notificación como no leída
  /// [notificationId] - ID de la notificación
  Future<AppNotification> markAsUnread(String notificationId);
  
  /// Elimina una notificación
  /// [notificationId] - ID de la notificación a eliminar
  Future<void> deleteNotification(String notificationId);
  
  /// Elimina múltiples notificaciones
  /// [notificationIds] - Lista de IDs de notificaciones
  Future<void> deleteNotifications(List<String> notificationIds);
  
  /// Elimina todas las notificaciones leídas de un usuario
  /// [userId] - ID del usuario
  /// [olderThanDays] - Eliminar solo las más antiguas que X días (opcional)
  Future<int> deleteReadNotificationsByUser(
    String userId, {
    int? olderThanDays,
  });
  
  /// Elimina notificaciones antiguas del sistema
  /// [olderThanDays] - Eliminar notificaciones más antiguas que X días
  Future<int> deleteOldNotifications(int olderThanDays);
  
  /// Obtiene el conteo de notificaciones no leídas de un usuario
  /// [userId] - ID del usuario
  /// [type] - Tipo específico (opcional)
  /// [priority] - Prioridad específica (opcional)
  Future<int> getUnreadNotificationsCount(
    String userId, {
    NotificationType? type,
    NotificationPriority? priority,
  });
  
  /// Obtiene el conteo total de notificaciones de un usuario
  /// [userId] - ID del usuario
  /// [type] - Tipo específico (opcional)
  Future<int> getTotalNotificationsCount(
    String userId, {
    NotificationType? type,
  });
  
  /// Obtiene estadísticas de notificaciones
  /// [userId] - ID del usuario (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getNotificationStats(
    DateTime startDate,
    DateTime endDate, {
    String? userId,
  });
  
  /// Obtiene estadísticas de notificaciones por tipo
  /// [userId] - ID del usuario (opcional)
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<NotificationType, int>> getNotificationStatsByType(
    DateTime startDate,
    DateTime endDate, {
    String? userId,
  });
  
  /// Envía una notificación push
  /// [notification] - Notificación a enviar
  /// [deviceTokens] - Tokens de dispositivos (opcional, se obtienen del usuario)
  Future<bool> sendPushNotification(
    AppNotification notification, {
    List<String>? deviceTokens,
  });
  
  /// Envía notificaciones push en lote
  /// [notifications] - Lista de notificaciones a enviar
  Future<Map<String, bool>> sendBatchPushNotifications(
    List<AppNotification> notifications,
  );
  
  /// Programa una notificación para envío futuro
  /// [notification] - Notificación a programar
  /// [scheduledTime] - Tiempo programado para el envío
  Future<AppNotification> scheduleNotification(
    AppNotification notification,
    DateTime scheduledTime,
  );
  
  /// Cancela una notificación programada
  /// [notificationId] - ID de la notificación programada
  Future<void> cancelScheduledNotification(String notificationId);
  
  /// Obtiene notificaciones programadas
  /// [userId] - ID del usuario (opcional)
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  Future<List<AppNotification>> getScheduledNotifications({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Procesa notificaciones programadas que deben enviarse
  Future<List<AppNotification>> processScheduledNotifications();
  
  /// Crea una notificación de pedido
  /// [userId] - ID del usuario
  /// [orderId] - ID del pedido
  /// [status] - Estado del pedido
  /// [title] - Título personalizado (opcional)
  /// [message] - Mensaje personalizado (opcional)
  Future<AppNotification> createOrderNotification(
    String userId,
    String orderId,
    String status, {
    String? title,
    String? message,
  });
  
  /// Crea una notificación de promoción
  /// [userId] - ID del usuario
  /// [promotionId] - ID de la promoción
  /// [storeId] - ID de la tienda
  /// [title] - Título de la promoción
  /// [message] - Mensaje de la promoción
  Future<AppNotification> createPromotionNotification(
    String userId,
    String promotionId,
    String storeId,
    String title,
    String message,
  );
  
  /// Crea una notificación de entrega
  /// [userId] - ID del usuario
  /// [deliveryId] - ID de la entrega
  /// [status] - Estado de la entrega
  /// [estimatedTime] - Tiempo estimado (opcional)
  Future<AppNotification> createDeliveryNotification(
    String userId,
    String deliveryId,
    String status, {
    String? estimatedTime,
  });
  
  /// Crea una notificación del sistema
  /// [userId] - ID del usuario (opcional, null para todos)
  /// [title] - Título de la notificación
  /// [message] - Mensaje de la notificación
  /// [priority] - Prioridad de la notificación
  Future<AppNotification> createSystemNotification(
    String title,
    String message,
    NotificationPriority priority, {
    String? userId,
  });
  
  /// Envía notificación a todos los usuarios de un rol específico
  /// [userRole] - Rol de usuarios a notificar
  /// [title] - Título de la notificación
  /// [message] - Mensaje de la notificación
  /// [type] - Tipo de notificación
  /// [priority] - Prioridad de la notificación
  Future<List<AppNotification>> sendNotificationToRole(
    String userRole,
    String title,
    String message,
    NotificationType type,
    NotificationPriority priority,
  );
}

/// Repositorio abstracto para la gestión de preferencias de notificación
abstract class NotificationPreferencesRepository {
  /// Obtiene las preferencias de notificación de un usuario
  /// [userId] - ID del usuario
  Future<NotificationPreferences?> getPreferencesByUser(String userId);
  
  /// Crea preferencias de notificación para un usuario
  /// [preferences] - Preferencias a crear
  Future<NotificationPreferences> createPreferences(
    NotificationPreferences preferences,
  );
  
  /// Actualiza las preferencias de notificación de un usuario
  /// [userId] - ID del usuario
  /// [updates] - Mapa con los campos a actualizar
  Future<NotificationPreferences> updatePreferences(
    String userId,
    Map<String, dynamic> updates,
  );
  
  /// Habilita/deshabilita notificaciones push para un usuario
  /// [userId] - ID del usuario
  /// [enabled] - Estado de las notificaciones push
  Future<NotificationPreferences> updatePushNotifications(
    String userId,
    bool enabled,
  );
  
  /// Actualiza las preferencias de un tipo específico de notificación
  /// [userId] - ID del usuario
  /// [type] - Tipo de notificación
  /// [enabled] - Estado de la notificación
  Future<NotificationPreferences> updateNotificationTypePreference(
    String userId,
    String type,
    bool enabled,
  );
  
  /// Actualiza las horas de silencio
  /// [userId] - ID del usuario
  /// [startTime] - Hora de inicio (formato HH:mm)
  /// [endTime] - Hora de fin (formato HH:mm)
  Future<NotificationPreferences> updateQuietHours(
    String userId,
    String? startTime,
    String? endTime,
  );
  
  /// Verifica si un usuario debe recibir notificaciones en este momento
  /// [userId] - ID del usuario
  /// [type] - Tipo de notificación
  Future<bool> shouldReceiveNotification(String userId, NotificationType type);
  
  /// Verifica si está en horas de silencio para un usuario
  /// [userId] - ID del usuario
  Future<bool> isInQuietHours(String userId);
  
  /// Obtiene usuarios que tienen habilitado un tipo específico de notificación
  /// [type] - Tipo de notificación
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<String>> getUsersWithNotificationTypeEnabled(
    NotificationType type, {
    int limit = 1000,
    int offset = 0,
  });
  
  /// Elimina las preferencias de un usuario
  /// [userId] - ID del usuario
  Future<void> deletePreferences(String userId);
  
  /// Restaura las preferencias por defecto para un usuario
  /// [userId] - ID del usuario
  Future<NotificationPreferences> resetToDefaults(String userId);
}