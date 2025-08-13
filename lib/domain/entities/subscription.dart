import 'package:equatable/equatable.dart';

/// Enumeración para los tipos de suscripción
enum SubscriptionType {
  store,    // Suscripción para dueños de colmado
  priority, // Suscripción prioritaria para clientes
}

/// Enumeración para los estados de suscripción
enum SubscriptionStatus {
  active,   // Activa
  expired,  // Expirada
  cancelled, // Cancelada
  pending,  // Pendiente de pago
}

/// Extensión para obtener texto legible de SubscriptionType
extension SubscriptionTypeExtension on SubscriptionType {
  String get displayName {
    switch (this) {
      case SubscriptionType.store:
        return 'Colmado';
      case SubscriptionType.priority:
        return 'Entrega Prioritaria';
    }
  }

  String get dbValue {
    switch (this) {
      case SubscriptionType.store:
        return 'store';
      case SubscriptionType.priority:
        return 'priority';
    }
  }

  static SubscriptionType fromString(String value) {
    switch (value) {
      case 'store':
        return SubscriptionType.store;
      case 'priority':
        return SubscriptionType.priority;
      default:
        return SubscriptionType.store;
    }
  }
}

/// Extensión para obtener texto legible de SubscriptionStatus
extension SubscriptionStatusExtension on SubscriptionStatus {
  String get displayName {
    switch (this) {
      case SubscriptionStatus.active:
        return 'Activa';
      case SubscriptionStatus.expired:
        return 'Expirada';
      case SubscriptionStatus.cancelled:
        return 'Cancelada';
      case SubscriptionStatus.pending:
        return 'Pendiente';
    }
  }

  String get dbValue {
    switch (this) {
      case SubscriptionStatus.active:
        return 'active';
      case SubscriptionStatus.expired:
        return 'expired';
      case SubscriptionStatus.cancelled:
        return 'cancelled';
      case SubscriptionStatus.pending:
        return 'pending';
    }
  }

  static SubscriptionStatus fromString(String value) {
    switch (value) {
      case 'active':
        return SubscriptionStatus.active;
      case 'expired':
        return SubscriptionStatus.expired;
      case 'cancelled':
        return SubscriptionStatus.cancelled;
      case 'pending':
        return SubscriptionStatus.pending;
      default:
        return SubscriptionStatus.pending;
    }
  }
}

/// Entidad que representa una suscripción
class Subscription extends Equatable {
  /// ID único de la suscripción (UUID)
  final String id;
  
  /// ID del usuario suscrito
  final String userId;
  
  /// Tipo de suscripción
  final SubscriptionType type;
  
  /// Estado de la suscripción
  final SubscriptionStatus status;
  
  /// Precio mensual de la suscripción
  final double monthlyPrice;
  
  /// Fecha de inicio de la suscripción
  final DateTime startDate;
  
  /// Fecha de expiración
  final DateTime expiryDate;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;
  
  /// Fecha de cancelación (si aplica)
  final DateTime? cancelledAt;
  
  /// Indica si la renovación automática está habilitada
  final bool autoRenew;
  
  /// Notas adicionales
  final String? notes;

  const Subscription({
    required this.id,
    required this.userId,
    required this.type,
    this.status = SubscriptionStatus.pending,
    required this.monthlyPrice,
    required this.startDate,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
    this.cancelledAt,
    this.autoRenew = true,
    this.notes,
  });

  /// Crea una copia de la suscripción con campos actualizados
  Subscription copyWith({
    String? id,
    String? userId,
    SubscriptionType? type,
    SubscriptionStatus? status,
    double? monthlyPrice,
    DateTime? startDate,
    DateTime? expiryDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? cancelledAt,
    bool? autoRenew,
    String? notes,
  }) {
    return Subscription(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      status: status ?? this.status,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
      startDate: startDate ?? this.startDate,
      expiryDate: expiryDate ?? this.expiryDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      autoRenew: autoRenew ?? this.autoRenew,
      notes: notes ?? this.notes,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.dbValue,
      'status': status.dbValue,
      'monthly_price': monthlyPrice,
      'start_date': startDate.toIso8601String(),
      'expiry_date': expiryDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'cancelled_at': cancelledAt?.toIso8601String(),
      'auto_renew': autoRenew,
      'notes': notes,
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: SubscriptionTypeExtension.fromString(json['type'] as String),
      status: SubscriptionStatusExtension.fromString(json['status'] as String),
      monthlyPrice: (json['monthly_price'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date'] as String),
      expiryDate: DateTime.parse(json['expiry_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      cancelledAt: json['cancelled_at'] != null 
          ? DateTime.parse(json['cancelled_at'] as String) 
          : null,
      autoRenew: json['auto_renew'] as bool? ?? true,
      notes: json['notes'] as String?,
    );
  }

  /// Verifica si la suscripción está activa
  bool get isActive => status == SubscriptionStatus.active;

  /// Verifica si la suscripción está expirada
  bool get isExpired {
    return status == SubscriptionStatus.expired || 
           (DateTime.now().isAfter(expiryDate) && status == SubscriptionStatus.active);
  }

  /// Verifica si la suscripción está cancelada
  bool get isCancelled => status == SubscriptionStatus.cancelled;

  /// Verifica si la suscripción está pendiente
  bool get isPending => status == SubscriptionStatus.pending;

  /// Obtiene el precio formateado
  String get formattedPrice => 'RD\$${monthlyPrice.toStringAsFixed(2)}';

  /// Obtiene los días restantes hasta la expiración
  int get daysUntilExpiry {
    final now = DateTime.now();
    if (now.isAfter(expiryDate)) return 0;
    return expiryDate.difference(now).inDays;
  }

  /// Obtiene el texto de días restantes
  String get daysUntilExpiryText {
    final days = daysUntilExpiry;
    if (days == 0) return 'Expira hoy';
    if (days == 1) return 'Expira mañana';
    if (days < 0) return 'Expirada';
    return 'Expira en $days días';
  }

  /// Verifica si la suscripción está próxima a expirar (menos de 7 días)
  bool get isNearExpiry {
    return daysUntilExpiry <= 7 && daysUntilExpiry > 0;
  }

  /// Obtiene la duración total de la suscripción en días
  int get totalDurationDays {
    return expiryDate.difference(startDate).inDays;
  }

  /// Obtiene el progreso de la suscripción (0.0 a 1.0)
  double get progress {
    final now = DateTime.now();
    if (now.isBefore(startDate)) return 0.0;
    if (now.isAfter(expiryDate)) return 1.0;
    
    final elapsed = now.difference(startDate).inDays;
    final total = totalDurationDays;
    return total > 0 ? elapsed / total : 1.0;
  }

  /// Activa la suscripción
  Subscription activate() {
    return copyWith(
      status: SubscriptionStatus.active,
      updatedAt: DateTime.now(),
    );
  }

  /// Cancela la suscripción
  Subscription cancel() {
    final now = DateTime.now();
    return copyWith(
      status: SubscriptionStatus.cancelled,
      cancelledAt: now,
      updatedAt: now,
      autoRenew: false,
    );
  }

  /// Marca la suscripción como expirada
  Subscription expire() {
    return copyWith(
      status: SubscriptionStatus.expired,
      updatedAt: DateTime.now(),
    );
  }

  /// Renueva la suscripción por un mes más
  Subscription renew() {
    final newExpiryDate = expiryDate.add(const Duration(days: 30));
    return copyWith(
      status: SubscriptionStatus.active,
      expiryDate: newExpiryDate,
      updatedAt: DateTime.now(),
    );
  }

  /// Obtiene los beneficios de la suscripción
  List<String> get benefits {
    switch (type) {
      case SubscriptionType.store:
        return [
          'Gestión completa de inventario',
          'Dashboard de ventas y estadísticas',
          'Gestión de pedidos en tiempo real',
          'Herramientas de promociones',
          'Soporte prioritario',
        ];
      case SubscriptionType.priority:
        return [
          'Entrega prioritaria en todos los pedidos',
          'Tiempo de entrega reducido',
          'Sin costo adicional por entrega rápida',
          'Notificaciones prioritarias',
        ];
    }
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        status,
        monthlyPrice,
        startDate,
        expiryDate,
        createdAt,
        updatedAt,
        cancelledAt,
        autoRenew,
        notes,
      ];

  @override
  String toString() {
    return 'Subscription(id: $id, type: ${type.displayName}, status: ${status.displayName})';
  }
}

/// Entidad que representa el historial de pagos de suscripciones
class SubscriptionPayment extends Equatable {
  /// ID único del pago (UUID)
  final String id;
  
  /// ID de la suscripción
  final String subscriptionId;
  
  /// Monto pagado
  final double amount;
  
  /// Método de pago utilizado
  final String paymentMethod;
  
  /// Fecha del pago
  final DateTime paymentDate;
  
  /// Período cubierto por el pago (inicio)
  final DateTime periodStart;
  
  /// Período cubierto por el pago (fin)
  final DateTime periodEnd;
  
  /// Indica si el pago fue exitoso
  final bool isSuccessful;
  
  /// ID de transacción externa (si aplica)
  final String? transactionId;
  
  /// Notas del pago
  final String? notes;

  const SubscriptionPayment({
    required this.id,
    required this.subscriptionId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
    required this.periodStart,
    required this.periodEnd,
    this.isSuccessful = true,
    this.transactionId,
    this.notes,
  });

  /// Crea una copia del pago con campos actualizados
  SubscriptionPayment copyWith({
    String? id,
    String? subscriptionId,
    double? amount,
    String? paymentMethod,
    DateTime? paymentDate,
    DateTime? periodStart,
    DateTime? periodEnd,
    bool? isSuccessful,
    String? transactionId,
    String? notes,
  }) {
    return SubscriptionPayment(
      id: id ?? this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentDate: paymentDate ?? this.paymentDate,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      transactionId: transactionId ?? this.transactionId,
      notes: notes ?? this.notes,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subscription_id': subscriptionId,
      'amount': amount,
      'payment_method': paymentMethod,
      'payment_date': paymentDate.toIso8601String(),
      'period_start': periodStart.toIso8601String(),
      'period_end': periodEnd.toIso8601String(),
      'is_successful': isSuccessful,
      'transaction_id': transactionId,
      'notes': notes,
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory SubscriptionPayment.fromJson(Map<String, dynamic> json) {
    return SubscriptionPayment(
      id: json['id'] as String,
      subscriptionId: json['subscription_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String,
      paymentDate: DateTime.parse(json['payment_date'] as String),
      periodStart: DateTime.parse(json['period_start'] as String),
      periodEnd: DateTime.parse(json['period_end'] as String),
      isSuccessful: json['is_successful'] as bool? ?? true,
      transactionId: json['transaction_id'] as String?,
      notes: json['notes'] as String?,
    );
  }

  /// Obtiene el monto formateado
  String get formattedAmount => 'RD\$${amount.toStringAsFixed(2)}';

  /// Obtiene la duración del período en días
  int get periodDurationDays {
    return periodEnd.difference(periodStart).inDays;
  }

  /// Obtiene el texto del período
  String get periodText {
    final startFormatted = '${periodStart.day}/${periodStart.month}/${periodStart.year}';
    final endFormatted = '${periodEnd.day}/${periodEnd.month}/${periodEnd.year}';
    return '$startFormatted - $endFormatted';
  }

  @override
  List<Object?> get props => [
        id,
        subscriptionId,
        amount,
        paymentMethod,
        paymentDate,
        periodStart,
        periodEnd,
        isSuccessful,
        transactionId,
        notes,
      ];

  @override
  String toString() {
    return 'SubscriptionPayment(id: $id, amount: $formattedAmount, successful: $isSuccessful)';
  }
}