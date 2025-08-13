import 'package:equatable/equatable.dart';

/// Enumeración para los tipos de notificación
enum NotificationType {
  orderUpdate,     // Actualización de pedido
  deliveryUpdate,  // Actualización de entrega
  promotion,       // Promoción
  subscription,    // Suscripción
  system,          // Sistema
  payment,         // Pago
  inventory,       // Inventario
  review,          // Reseña
}

/// Enumeración para la prioridad de notificación
enum NotificationPriority {
  low,    // Baja
  normal, // Normal
  high,   // Alta
  urgent, // Urgente
}

/// Extensión para obtener texto legible de NotificationType
extension NotificationTypeExtension on NotificationType {
  String get displayName {
    switch (this) {
      case NotificationType.orderUpdate:
        return 'Pedido';
      case NotificationType.deliveryUpdate:
        return 'Entrega';
      case NotificationType.promotion:
        return 'Promoción';
      case NotificationType.subscription:
        return 'Suscripción';
      case NotificationType.system:
        return 'Sistema';
      case NotificationType.payment:
        return 'Pago';
      case NotificationType.inventory:
        return 'Inventario';
      case NotificationType.review:
        return 'Reseña';
    }
  }

  String get dbValue {
    switch (this) {
      case NotificationType.orderUpdate:
        return 'order_update';
      case NotificationType.deliveryUpdate:
        return 'delivery_update';
      case NotificationType.promotion:
        return 'promotion';
      case NotificationType.subscription:
        return 'subscription';
      case NotificationType.system:
        return 'system';
      case NotificationType.payment:
        return 'payment';
      case NotificationType.inventory:
        return 'inventory';
      case NotificationType.review:
        return 'review';
    }
  }

  String get iconName {
    switch (this) {
      case NotificationType.orderUpdate:
        return 'shopping_bag';
      case NotificationType.deliveryUpdate:
        return 'local_shipping';
      case NotificationType.promotion:
        return 'local_offer';
      case NotificationType.subscription:
        return 'card_membership';
      case NotificationType.system:
        return 'settings';
      case NotificationType.payment:
        return 'payment';
      case NotificationType.inventory:
        return 'inventory';
      case NotificationType.review:
        return 'star';
    }
  }

  static NotificationType fromString(String value) {
    switch (value) {
      case 'order_update':
        return NotificationType.orderUpdate;
      case 'delivery_update':
        return NotificationType.deliveryUpdate;
      case 'promotion':
        return NotificationType.promotion;
      case 'subscription':
        return NotificationType.subscription;
      case 'system':
        return NotificationType.system;
      case 'payment':
        return NotificationType.payment;
      case 'inventory':
        return NotificationType.inventory;
      case 'review':
        return NotificationType.review;
      default:
        return NotificationType.system;
    }
  }
}

/// Extensión para obtener texto legible de NotificationPriority
extension NotificationPriorityExtension on NotificationPriority {
  String get displayName {
    switch (this) {
      case NotificationPriority.low:
        return 'Baja';
      case NotificationPriority.normal:
        return 'Normal';
      case NotificationPriority.high:
        return 'Alta';
      case NotificationPriority.urgent:
        return 'Urgente';
    }
  }

  String get dbValue {
    switch (this) {
      case NotificationPriority.low:
        return 'low';
      case NotificationPriority.normal:
        return 'normal';
      case NotificationPriority.high:
        return 'high';
      case NotificationPriority.urgent:
        return 'urgent';
    }
  }

  static NotificationPriority fromString(String value) {
    switch (value) {
      case 'low':
        return NotificationPriority.low;
      case 'normal':
        return NotificationPriority.normal;
      case 'high':
        return NotificationPriority.high;
      case 'urgent':
        return NotificationPriority.urgent;
      default:
        return NotificationPriority.normal;
    }
  }
}

/// Entidad que representa una notificación
class AppNotification extends Equatable {
  /// ID único de la notificación (UUID)
  final String id;
  
  /// ID del usuario destinatario
  final String userId;
  
  /// Tipo de notificación
  final NotificationType type;
  
  /// Prioridad de la notificación
  final NotificationPriority priority;
  
  /// Título de la notificación
  final String title;
  
  /// Mensaje de la notificación
  final String message;
  
  /// Datos adicionales en formato JSON (opcional)
  final Map<String, dynamic>? data;
  
  /// URL de imagen (opcional)
  final String? imageUrl;
  
  /// URL de acción (opcional)
  final String? actionUrl;
  
  /// Texto del botón de acción (opcional)
  final String? actionText;
  
  /// Indica si la notificación ha sido leída
  final bool isRead;
  
  /// Indica si la notificación ha sido enviada por push
  final bool isPushSent;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de lectura (si aplica)
  final DateTime? readAt;
  
  /// Fecha de expiración (opcional)
  final DateTime? expiresAt;

  const AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    this.priority = NotificationPriority.normal,
    required this.title,
    required this.message,
    this.data,
    this.imageUrl,
    this.actionUrl,
    this.actionText,
    this.isRead = false,
    this.isPushSent = false,
    required this.createdAt,
    this.readAt,
    this.expiresAt,
  });

  /// Crea una copia de la notificación con campos actualizados
  AppNotification copyWith({
    String? id,
    String? userId,
    NotificationType? type,
    NotificationPriority? priority,
    String? title,
    String? message,
    Map<String, dynamic>? data,
    String? imageUrl,
    String? actionUrl,
    String? actionText,
    bool? isRead,
    bool? isPushSent,
    DateTime? createdAt,
    DateTime? readAt,
    DateTime? expiresAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      title: title ?? this.title,
      message: message ?? this.message,
      data: data ?? this.data,
      imageUrl: imageUrl ?? this.imageUrl,
      actionUrl: actionUrl ?? this.actionUrl,
      actionText: actionText ?? this.actionText,
      isRead: isRead ?? this.isRead,
      isPushSent: isPushSent ?? this.isPushSent,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.dbValue,
      'priority': priority.dbValue,
      'title': title,
      'message': message,
      'data': data,
      'image_url': imageUrl,
      'action_url': actionUrl,
      'action_text': actionText,
      'is_read': isRead,
      'is_push_sent': isPushSent,
      'created_at': createdAt.toIso8601String(),
      'read_at': readAt?.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: NotificationTypeExtension.fromString(json['type'] as String),
      priority: NotificationPriorityExtension.fromString(json['priority'] as String),
      title: json['title'] as String,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
      imageUrl: json['image_url'] as String?,
      actionUrl: json['action_url'] as String?,
      actionText: json['action_text'] as String?,
      isRead: json['is_read'] as bool? ?? false,
      isPushSent: json['is_push_sent'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      readAt: json['read_at'] != null 
          ? DateTime.parse(json['read_at'] as String) 
          : null,
      expiresAt: json['expires_at'] != null 
          ? DateTime.parse(json['expires_at'] as String) 
          : null,
    );
  }

  /// Verifica si la notificación está expirada
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  /// Verifica si la notificación es nueva (menos de 24 horas)
  bool get isNew {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inHours < 24;
  }

  /// Verifica si la notificación tiene acción
  bool get hasAction => actionUrl != null && actionText != null;

  /// Obtiene el tiempo transcurrido desde la creación
  Duration get timeElapsed => DateTime.now().difference(createdAt);

  /// Obtiene el tiempo transcurrido formateado
  String get formattedTimeElapsed {
    final elapsed = timeElapsed;
    
    if (elapsed.inDays > 0) {
      return 'hace ${elapsed.inDays} día${elapsed.inDays > 1 ? 's' : ''}';
    } else if (elapsed.inHours > 0) {
      return 'hace ${elapsed.inHours} hora${elapsed.inHours > 1 ? 's' : ''}';
    } else if (elapsed.inMinutes > 0) {
      return 'hace ${elapsed.inMinutes} minuto${elapsed.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'hace un momento';
    }
  }

  /// Obtiene el color asociado a la prioridad
  String get priorityColor {
    switch (priority) {
      case NotificationPriority.low:
        return '#4CAF50'; // Verde
      case NotificationPriority.normal:
        return '#2196F3'; // Azul
      case NotificationPriority.high:
        return '#FF9800'; // Naranja
      case NotificationPriority.urgent:
        return '#F44336'; // Rojo
    }
  }

  /// Marca la notificación como leída
  AppNotification markAsRead() {
    if (isRead) return this;
    return copyWith(
      isRead: true,
      readAt: DateTime.now(),
    );
  }

  /// Marca la notificación como no leída
  AppNotification markAsUnread() {
    if (!isRead) return this;
    return copyWith(
      isRead: false,
      readAt: null,
    );
  }

  /// Marca la notificación como enviada por push
  AppNotification markPushSent() {
    return copyWith(isPushSent: true);
  }

  /// Obtiene un valor específico de los datos adicionales
  T? getDataValue<T>(String key) {
    if (data == null) return null;
    return data![key] as T?;
  }

  /// Verifica si contiene un valor específico en los datos
  bool hasDataValue(String key) {
    return data?.containsKey(key) ?? false;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        priority,
        title,
        message,
        data,
        imageUrl,
        actionUrl,
        actionText,
        isRead,
        isPushSent,
        createdAt,
        readAt,
        expiresAt,
      ];

  @override
  String toString() {
    return 'AppNotification(id: $id, type: ${type.displayName}, title: $title, isRead: $isRead)';
  }
}

/// Entidad que representa las preferencias de notificación de un usuario
class NotificationPreferences extends Equatable {
  /// ID del usuario
  final String userId;
  
  /// Notificaciones push habilitadas
  final bool pushEnabled;
  
  /// Notificaciones de pedidos habilitadas
  final bool orderNotifications;
  
  /// Notificaciones de entrega habilitadas
  final bool deliveryNotifications;
  
  /// Notificaciones de promociones habilitadas
  final bool promotionNotifications;
  
  /// Notificaciones de suscripción habilitadas
  final bool subscriptionNotifications;
  
  /// Notificaciones del sistema habilitadas
  final bool systemNotifications;
  
  /// Notificaciones de pago habilitadas
  final bool paymentNotifications;
  
  /// Notificaciones de inventario habilitadas (solo para dueños)
  final bool inventoryNotifications;
  
  /// Notificaciones de reseñas habilitadas
  final bool reviewNotifications;
  
  /// Horario de inicio para no molestar (24h format)
  final String? quietHoursStart;
  
  /// Horario de fin para no molestar (24h format)
  final String? quietHoursEnd;
  
  /// Fecha de última actualización
  final DateTime updatedAt;

  const NotificationPreferences({
    required this.userId,
    this.pushEnabled = true,
    this.orderNotifications = true,
    this.deliveryNotifications = true,
    this.promotionNotifications = true,
    this.subscriptionNotifications = true,
    this.systemNotifications = true,
    this.paymentNotifications = true,
    this.inventoryNotifications = false,
    this.reviewNotifications = true,
    this.quietHoursStart,
    this.quietHoursEnd,
    required this.updatedAt,
  });

  /// Crea una copia de las preferencias con campos actualizados
  NotificationPreferences copyWith({
    String? userId,
    bool? pushEnabled,
    bool? orderNotifications,
    bool? deliveryNotifications,
    bool? promotionNotifications,
    bool? subscriptionNotifications,
    bool? systemNotifications,
    bool? paymentNotifications,
    bool? inventoryNotifications,
    bool? reviewNotifications,
    String? quietHoursStart,
    String? quietHoursEnd,
    DateTime? updatedAt,
  }) {
    return NotificationPreferences(
      userId: userId ?? this.userId,
      pushEnabled: pushEnabled ?? this.pushEnabled,
      orderNotifications: orderNotifications ?? this.orderNotifications,
      deliveryNotifications: deliveryNotifications ?? this.deliveryNotifications,
      promotionNotifications: promotionNotifications ?? this.promotionNotifications,
      subscriptionNotifications: subscriptionNotifications ?? this.subscriptionNotifications,
      systemNotifications: systemNotifications ?? this.systemNotifications,
      paymentNotifications: paymentNotifications ?? this.paymentNotifications,
      inventoryNotifications: inventoryNotifications ?? this.inventoryNotifications,
      reviewNotifications: reviewNotifications ?? this.reviewNotifications,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'push_enabled': pushEnabled,
      'order_notifications': orderNotifications,
      'delivery_notifications': deliveryNotifications,
      'promotion_notifications': promotionNotifications,
      'subscription_notifications': subscriptionNotifications,
      'system_notifications': systemNotifications,
      'payment_notifications': paymentNotifications,
      'inventory_notifications': inventoryNotifications,
      'review_notifications': reviewNotifications,
      'quiet_hours_start': quietHoursStart,
      'quiet_hours_end': quietHoursEnd,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      userId: json['user_id'] as String,
      pushEnabled: json['push_enabled'] as bool? ?? true,
      orderNotifications: json['order_notifications'] as bool? ?? true,
      deliveryNotifications: json['delivery_notifications'] as bool? ?? true,
      promotionNotifications: json['promotion_notifications'] as bool? ?? true,
      subscriptionNotifications: json['subscription_notifications'] as bool? ?? true,
      systemNotifications: json['system_notifications'] as bool? ?? true,
      paymentNotifications: json['payment_notifications'] as bool? ?? true,
      inventoryNotifications: json['inventory_notifications'] as bool? ?? false,
      reviewNotifications: json['review_notifications'] as bool? ?? true,
      quietHoursStart: json['quiet_hours_start'] as String?,
      quietHoursEnd: json['quiet_hours_end'] as String?,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Verifica si un tipo de notificación está habilitado
  bool isTypeEnabled(NotificationType type) {
    switch (type) {
      case NotificationType.orderUpdate:
        return orderNotifications;
      case NotificationType.deliveryUpdate:
        return deliveryNotifications;
      case NotificationType.promotion:
        return promotionNotifications;
      case NotificationType.subscription:
        return subscriptionNotifications;
      case NotificationType.system:
        return systemNotifications;
      case NotificationType.payment:
        return paymentNotifications;
      case NotificationType.inventory:
        return inventoryNotifications;
      case NotificationType.review:
        return reviewNotifications;
    }
  }

  /// Verifica si está en horario de no molestar
  bool get isInQuietHours {
    if (quietHoursStart == null || quietHoursEnd == null) return false;
    
    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    
    // Comparación simple de strings en formato HH:mm
    return currentTime.compareTo(quietHoursStart!) >= 0 && 
           currentTime.compareTo(quietHoursEnd!) <= 0;
  }

  /// Habilita todas las notificaciones
  NotificationPreferences enableAll() {
    return copyWith(
      pushEnabled: true,
      orderNotifications: true,
      deliveryNotifications: true,
      promotionNotifications: true,
      subscriptionNotifications: true,
      systemNotifications: true,
      paymentNotifications: true,
      reviewNotifications: true,
      updatedAt: DateTime.now(),
    );
  }

  /// Deshabilita todas las notificaciones
  NotificationPreferences disableAll() {
    return copyWith(
      pushEnabled: false,
      orderNotifications: false,
      deliveryNotifications: false,
      promotionNotifications: false,
      subscriptionNotifications: false,
      systemNotifications: false,
      paymentNotifications: false,
      inventoryNotifications: false,
      reviewNotifications: false,
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        userId,
        pushEnabled,
        orderNotifications,
        deliveryNotifications,
        promotionNotifications,
        subscriptionNotifications,
        systemNotifications,
        paymentNotifications,
        inventoryNotifications,
        reviewNotifications,
        quietHoursStart,
        quietHoursEnd,
        updatedAt,
      ];

  @override
  String toString() {
    return 'NotificationPreferences(userId: $userId, pushEnabled: $pushEnabled)';
  }
}