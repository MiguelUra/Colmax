import 'package:equatable/equatable.dart';

/// Enumeración para los tipos de promoción
enum PromotionType {
  percentage, // Descuento por porcentaje
  fixed,      // Descuento fijo
  bogo,       // Compra uno, lleva otro
  freeShipping, // Envío gratis
}

/// Enumeración para el estado de la promoción
enum PromotionStatus {
  draft,    // Borrador
  active,   // Activa
  paused,   // Pausada
  expired,  // Expirada
  cancelled, // Cancelada
}

/// Extensión para obtener texto legible de PromotionType
extension PromotionTypeExtension on PromotionType {
  String get displayName {
    switch (this) {
      case PromotionType.percentage:
        return 'Descuento %';
      case PromotionType.fixed:
        return 'Descuento Fijo';
      case PromotionType.bogo:
        return 'Compra 1 Lleva 2';
      case PromotionType.freeShipping:
        return 'Envío Gratis';
    }
  }

  String get dbValue {
    switch (this) {
      case PromotionType.percentage:
        return 'percentage';
      case PromotionType.fixed:
        return 'fixed';
      case PromotionType.bogo:
        return 'bogo';
      case PromotionType.freeShipping:
        return 'free_shipping';
    }
  }

  static PromotionType fromString(String value) {
    switch (value) {
      case 'percentage':
        return PromotionType.percentage;
      case 'fixed':
        return PromotionType.fixed;
      case 'bogo':
        return PromotionType.bogo;
      case 'free_shipping':
        return PromotionType.freeShipping;
      default:
        return PromotionType.percentage;
    }
  }
}

/// Extensión para obtener texto legible de PromotionStatus
extension PromotionStatusExtension on PromotionStatus {
  String get displayName {
    switch (this) {
      case PromotionStatus.draft:
        return 'Borrador';
      case PromotionStatus.active:
        return 'Activa';
      case PromotionStatus.paused:
        return 'Pausada';
      case PromotionStatus.expired:
        return 'Expirada';
      case PromotionStatus.cancelled:
        return 'Cancelada';
    }
  }

  String get dbValue {
    switch (this) {
      case PromotionStatus.draft:
        return 'draft';
      case PromotionStatus.active:
        return 'active';
      case PromotionStatus.paused:
        return 'paused';
      case PromotionStatus.expired:
        return 'expired';
      case PromotionStatus.cancelled:
        return 'cancelled';
    }
  }

  static PromotionStatus fromString(String value) {
    switch (value) {
      case 'draft':
        return PromotionStatus.draft;
      case 'active':
        return PromotionStatus.active;
      case 'paused':
        return PromotionStatus.paused;
      case 'expired':
        return PromotionStatus.expired;
      case 'cancelled':
        return PromotionStatus.cancelled;
      default:
        return PromotionStatus.draft;
    }
  }
}

/// Entidad que representa una promoción
class Promotion extends Equatable {
  /// ID único de la promoción (UUID)
  final String id;
  
  /// ID del colmado que creó la promoción
  final String storeId;
  
  /// Nombre de la promoción
  final String name;
  
  /// Descripción de la promoción
  final String description;
  
  /// Tipo de promoción
  final PromotionType type;
  
  /// Estado de la promoción
  final PromotionStatus status;
  
  /// Valor del descuento (porcentaje o monto fijo)
  final double discountValue;
  
  /// Monto mínimo de compra para aplicar la promoción
  final double? minimumPurchase;
  
  /// Monto máximo de descuento (para porcentajes)
  final double? maximumDiscount;
  
  /// Lista de IDs de productos aplicables (vacía = todos)
  final List<String> applicableProductIds;
  
  /// Lista de IDs de categorías aplicables (vacía = todas)
  final List<String> applicableCategoryIds;
  
  /// Código promocional (opcional)
  final String? promoCode;
  
  /// Número máximo de usos totales
  final int? maxTotalUses;
  
  /// Número máximo de usos por usuario
  final int? maxUsesPerUser;
  
  /// Número actual de usos
  final int currentUses;
  
  /// URL de imagen promocional
  final String? imageUrl;
  
  /// Fecha de inicio
  final DateTime startDate;
  
  /// Fecha de fin
  final DateTime endDate;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;

  const Promotion({
    required this.id,
    required this.storeId,
    required this.name,
    required this.description,
    required this.type,
    this.status = PromotionStatus.draft,
    required this.discountValue,
    this.minimumPurchase,
    this.maximumDiscount,
    this.applicableProductIds = const [],
    this.applicableCategoryIds = const [],
    this.promoCode,
    this.maxTotalUses,
    this.maxUsesPerUser,
    this.currentUses = 0,
    this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Crea una copia de la promoción con campos actualizados
  Promotion copyWith({
    String? id,
    String? storeId,
    String? name,
    String? description,
    PromotionType? type,
    PromotionStatus? status,
    double? discountValue,
    double? minimumPurchase,
    double? maximumDiscount,
    List<String>? applicableProductIds,
    List<String>? applicableCategoryIds,
    String? promoCode,
    int? maxTotalUses,
    int? maxUsesPerUser,
    int? currentUses,
    String? imageUrl,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Promotion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      discountValue: discountValue ?? this.discountValue,
      minimumPurchase: minimumPurchase ?? this.minimumPurchase,
      maximumDiscount: maximumDiscount ?? this.maximumDiscount,
      applicableProductIds: applicableProductIds ?? this.applicableProductIds,
      applicableCategoryIds: applicableCategoryIds ?? this.applicableCategoryIds,
      promoCode: promoCode ?? this.promoCode,
      maxTotalUses: maxTotalUses ?? this.maxTotalUses,
      maxUsesPerUser: maxUsesPerUser ?? this.maxUsesPerUser,
      currentUses: currentUses ?? this.currentUses,
      imageUrl: imageUrl ?? this.imageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'name': name,
      'description': description,
      'type': type.dbValue,
      'status': status.dbValue,
      'discount_value': discountValue,
      'minimum_purchase': minimumPurchase,
      'maximum_discount': maximumDiscount,
      'applicable_product_ids': applicableProductIds,
      'applicable_category_ids': applicableCategoryIds,
      'promo_code': promoCode,
      'max_total_uses': maxTotalUses,
      'max_uses_per_user': maxUsesPerUser,
      'current_uses': currentUses,
      'image_url': imageUrl,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: PromotionTypeExtension.fromString(json['type'] as String),
      status: PromotionStatusExtension.fromString(json['status'] as String),
      discountValue: (json['discount_value'] as num).toDouble(),
      minimumPurchase: (json['minimum_purchase'] as num?)?.toDouble(),
      maximumDiscount: (json['maximum_discount'] as num?)?.toDouble(),
      applicableProductIds: List<String>.from(json['applicable_product_ids'] as List? ?? []),
      applicableCategoryIds: List<String>.from(json['applicable_category_ids'] as List? ?? []),
      promoCode: json['promo_code'] as String?,
      maxTotalUses: json['max_total_uses'] as int?,
      maxUsesPerUser: json['max_uses_per_user'] as int?,
      currentUses: json['current_uses'] as int? ?? 0,
      imageUrl: json['image_url'] as String?,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Verifica si la promoción está activa
  bool get isActive {
    final now = DateTime.now();
    return status == PromotionStatus.active &&
           now.isAfter(startDate) &&
           now.isBefore(endDate);
  }

  /// Verifica si la promoción está expirada
  bool get isExpired {
    final now = DateTime.now();
    return now.isAfter(endDate) || status == PromotionStatus.expired;
  }

  /// Verifica si la promoción está próxima a expirar (menos de 24 horas)
  bool get isNearExpiry {
    final now = DateTime.now();
    final hoursUntilExpiry = endDate.difference(now).inHours;
    return hoursUntilExpiry <= 24 && hoursUntilExpiry > 0;
  }

  /// Verifica si la promoción ha alcanzado el límite de usos
  bool get hasReachedUsageLimit {
    return maxTotalUses != null && currentUses >= maxTotalUses!;
  }

  /// Verifica si la promoción puede ser usada
  bool get canBeUsed {
    return isActive && !hasReachedUsageLimit;
  }

  /// Verifica si aplica a todos los productos
  bool get appliesToAllProducts {
    return applicableProductIds.isEmpty && applicableCategoryIds.isEmpty;
  }

  /// Obtiene el descuento formateado
  String get formattedDiscount {
    switch (type) {
      case PromotionType.percentage:
        return '${discountValue.toStringAsFixed(0)}% OFF';
      case PromotionType.fixed:
        return 'RD\$${discountValue.toStringAsFixed(2)} OFF';
      case PromotionType.bogo:
        return 'Compra 1 Lleva 2';
      case PromotionType.freeShipping:
        return 'Envío Gratis';
    }
  }

  /// Obtiene el mínimo de compra formateado
  String get formattedMinimumPurchase {
    if (minimumPurchase == null) return 'Sin mínimo';
    return 'Mínimo RD\$${minimumPurchase!.toStringAsFixed(2)}';
  }

  /// Obtiene los días restantes hasta la expiración
  int get daysUntilExpiry {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays;
  }

  /// Obtiene el texto de días restantes
  String get daysUntilExpiryText {
    final days = daysUntilExpiry;
    if (days == 0) return 'Expira hoy';
    if (days == 1) return 'Expira mañana';
    if (days < 0) return 'Expirada';
    return 'Expira en $days días';
  }

  /// Obtiene el porcentaje de uso
  double get usagePercentage {
    if (maxTotalUses == null || maxTotalUses! == 0) return 0.0;
    return (currentUses / maxTotalUses!).clamp(0.0, 1.0);
  }

  /// Calcula el descuento para un monto específico
  double calculateDiscount(double amount) {
    if (!canBeUsed) return 0.0;
    if (minimumPurchase != null && amount < minimumPurchase!) return 0.0;

    switch (type) {
      case PromotionType.percentage:
        double discount = amount * (discountValue / 100);
        if (maximumDiscount != null && discount > maximumDiscount!) {
          discount = maximumDiscount!;
        }
        return discount;
      case PromotionType.fixed:
        return discountValue.clamp(0.0, amount);
      case PromotionType.bogo:
        // Lógica específica para BOGO se implementaría según las reglas de negocio
        return 0.0;
      case PromotionType.freeShipping:
        // El descuento en envío se manejaría en otra parte
        return 0.0;
    }
  }

  /// Verifica si la promoción aplica a un producto específico
  bool appliesToProduct(String productId, String? categoryId) {
    if (appliesToAllProducts) return true;
    
    if (applicableProductIds.contains(productId)) return true;
    
    if (categoryId != null && applicableCategoryIds.contains(categoryId)) {
      return true;
    }
    
    return false;
  }

  /// Incrementa el contador de usos
  Promotion incrementUsage() {
    return copyWith(
      currentUses: currentUses + 1,
      updatedAt: DateTime.now(),
    );
  }

  /// Activa la promoción
  Promotion activate() {
    return copyWith(
      status: PromotionStatus.active,
      updatedAt: DateTime.now(),
    );
  }

  /// Pausa la promoción
  Promotion pause() {
    return copyWith(
      status: PromotionStatus.paused,
      updatedAt: DateTime.now(),
    );
  }

  /// Cancela la promoción
  Promotion cancel() {
    return copyWith(
      status: PromotionStatus.cancelled,
      updatedAt: DateTime.now(),
    );
  }

  /// Marca la promoción como expirada
  Promotion expire() {
    return copyWith(
      status: PromotionStatus.expired,
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        storeId,
        name,
        description,
        type,
        status,
        discountValue,
        minimumPurchase,
        maximumDiscount,
        applicableProductIds,
        applicableCategoryIds,
        promoCode,
        maxTotalUses,
        maxUsesPerUser,
        currentUses,
        imageUrl,
        startDate,
        endDate,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'Promotion(id: $id, name: $name, discount: $formattedDiscount, status: ${status.displayName})';
  }
}

/// Entidad que representa el uso de una promoción por un usuario
class PromotionUsage extends Equatable {
  /// ID único del uso (UUID)
  final String id;
  
  /// ID de la promoción
  final String promotionId;
  
  /// ID del usuario que usó la promoción
  final String userId;
  
  /// ID del pedido donde se aplicó
  final String orderId;
  
  /// Monto del descuento aplicado
  final double discountAmount;
  
  /// Fecha de uso
  final DateTime usedAt;

  const PromotionUsage({
    required this.id,
    required this.promotionId,
    required this.userId,
    required this.orderId,
    required this.discountAmount,
    required this.usedAt,
  });

  /// Crea una copia del uso con campos actualizados
  PromotionUsage copyWith({
    String? id,
    String? promotionId,
    String? userId,
    String? orderId,
    double? discountAmount,
    DateTime? usedAt,
  }) {
    return PromotionUsage(
      id: id ?? this.id,
      promotionId: promotionId ?? this.promotionId,
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      discountAmount: discountAmount ?? this.discountAmount,
      usedAt: usedAt ?? this.usedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'promotion_id': promotionId,
      'user_id': userId,
      'order_id': orderId,
      'discount_amount': discountAmount,
      'used_at': usedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory PromotionUsage.fromJson(Map<String, dynamic> json) {
    return PromotionUsage(
      id: json['id'] as String,
      promotionId: json['promotion_id'] as String,
      userId: json['user_id'] as String,
      orderId: json['order_id'] as String,
      discountAmount: (json['discount_amount'] as num).toDouble(),
      usedAt: DateTime.parse(json['used_at'] as String),
    );
  }

  /// Obtiene el descuento formateado
  String get formattedDiscount => 'RD\$${discountAmount.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [
        id,
        promotionId,
        userId,
        orderId,
        discountAmount,
        usedAt,
      ];

  @override
  String toString() {
    return 'PromotionUsage(id: $id, discount: $formattedDiscount)';
  }
}