import 'package:equatable/equatable.dart';

/// Enumeración para los estados de un pedido
enum OrderStatus {
  pending,    // Pendiente
  confirmed,  // Confirmado
  preparing,  // Preparando
  ready,      // Listo
  inDelivery, // En entrega
  delivered,  // Entregado
  cancelled,  // Cancelado
}

/// Enumeración para los métodos de pago
enum PaymentMethod {
  cash,       // Efectivo
  card,       // Tarjeta
  transfer,   // Transferencia
}

/// Extensión para obtener texto legible de OrderStatus
extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.preparing:
        return 'Preparando';
      case OrderStatus.ready:
        return 'Listo';
      case OrderStatus.inDelivery:
        return 'En entrega';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }

  String get dbValue {
    switch (this) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.confirmed:
        return 'confirmed';
      case OrderStatus.preparing:
        return 'preparing';
      case OrderStatus.ready:
        return 'ready';
      case OrderStatus.inDelivery:
        return 'in_delivery';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.cancelled:
        return 'cancelled';
    }
  }

  static OrderStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return OrderStatus.pending;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'preparing':
        return OrderStatus.preparing;
      case 'ready':
        return OrderStatus.ready;
      case 'in_delivery':
        return OrderStatus.inDelivery;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
}

/// Extensión para obtener texto legible de PaymentMethod
extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Efectivo';
      case PaymentMethod.card:
        return 'Tarjeta';
      case PaymentMethod.transfer:
        return 'Transferencia';
    }
  }

  String get dbValue {
    switch (this) {
      case PaymentMethod.cash:
        return 'cash';
      case PaymentMethod.card:
        return 'card';
      case PaymentMethod.transfer:
        return 'transfer';
    }
  }

  static PaymentMethod fromString(String value) {
    switch (value) {
      case 'cash':
        return PaymentMethod.cash;
      case 'card':
        return PaymentMethod.card;
      case 'transfer':
        return PaymentMethod.transfer;
      default:
        return PaymentMethod.cash;
    }
  }
}

/// Entidad que representa un pedido
class Order extends Equatable {
  /// ID único del pedido (UUID)
  final String id;
  
  /// ID del cliente que realizó el pedido
  final String customerId;
  
  /// ID del colmado donde se realizó el pedido
  final String storeId;
  
  /// Estado actual del pedido
  final OrderStatus status;
  
  /// Subtotal del pedido (sin delivery)
  final double subtotal;
  
  /// Costo de delivery
  final double deliveryFee;
  
  /// Total del pedido (subtotal + delivery)
  final double total;
  
  /// Método de pago seleccionado
  final PaymentMethod paymentMethod;
  
  /// Indica si el pago ha sido procesado
  final bool isPaid;
  
  /// Dirección de entrega
  final String deliveryAddress;
  
  /// Latitud de la dirección de entrega
  final double deliveryLatitude;
  
  /// Longitud de la dirección de entrega
  final double deliveryLongitude;
  
  /// Notas especiales del cliente (opcional)
  final String? notes;
  
  /// Tiempo estimado de entrega en minutos
  final int? estimatedDeliveryTime;
  
  /// ID del repartidor asignado (opcional)
  final String? deliveryPersonId;
  
  /// Indica si es un pedido prioritario
  final bool isPriority;
  
  /// Fecha de creación del pedido
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;
  
  /// Fecha de entrega (cuando se completa)
  final DateTime? deliveredAt;

  const Order({
    required this.id,
    required this.customerId,
    required this.storeId,
    this.status = OrderStatus.pending,
    required this.subtotal,
    this.deliveryFee = 0.0,
    required this.total,
    this.paymentMethod = PaymentMethod.cash,
    this.isPaid = false,
    required this.deliveryAddress,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    this.notes,
    this.estimatedDeliveryTime,
    this.deliveryPersonId,
    this.isPriority = false,
    required this.createdAt,
    required this.updatedAt,
    this.deliveredAt,
  });

  /// Crea una copia del pedido con campos actualizados
  Order copyWith({
    String? id,
    String? customerId,
    String? storeId,
    OrderStatus? status,
    double? subtotal,
    double? deliveryFee,
    double? total,
    PaymentMethod? paymentMethod,
    bool? isPaid,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    String? notes,
    int? estimatedDeliveryTime,
    String? deliveryPersonId,
    bool? isPriority,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deliveredAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      storeId: storeId ?? this.storeId,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
      notes: notes ?? this.notes,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      deliveryPersonId: deliveryPersonId ?? this.deliveryPersonId,
      isPriority: isPriority ?? this.isPriority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'store_id': storeId,
      'status': status.dbValue,
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'total': total,
      'payment_method': paymentMethod.dbValue,
      'is_paid': isPaid,
      'delivery_address': deliveryAddress,
      'delivery_latitude': deliveryLatitude,
      'delivery_longitude': deliveryLongitude,
      'notes': notes,
      'estimated_delivery_time': estimatedDeliveryTime,
      'delivery_person_id': deliveryPersonId,
      'is_priority': isPriority,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'delivered_at': deliveredAt?.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      storeId: json['store_id'] as String,
      status: OrderStatusExtension.fromString(json['status'] as String),
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num).toDouble(),
      paymentMethod: PaymentMethodExtension.fromString(json['payment_method'] as String),
      isPaid: json['is_paid'] as bool? ?? false,
      deliveryAddress: json['delivery_address'] as String,
      deliveryLatitude: (json['delivery_latitude'] as num).toDouble(),
      deliveryLongitude: (json['delivery_longitude'] as num).toDouble(),
      notes: json['notes'] as String?,
      estimatedDeliveryTime: json['estimated_delivery_time'] as int?,
      deliveryPersonId: json['delivery_person_id'] as String?,
      isPriority: json['is_priority'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deliveredAt: json['delivered_at'] != null 
          ? DateTime.parse(json['delivered_at'] as String) 
          : null,
    );
  }

  /// Verifica si el pedido puede ser cancelado
  bool get canBeCancelled {
    return status == OrderStatus.pending || status == OrderStatus.confirmed;
  }

  /// Verifica si el pedido está en proceso
  bool get isInProgress {
    return status == OrderStatus.confirmed || 
           status == OrderStatus.preparing || 
           status == OrderStatus.ready || 
           status == OrderStatus.inDelivery;
  }

  /// Verifica si el pedido está completado
  bool get isCompleted {
    return status == OrderStatus.delivered;
  }

  /// Verifica si el pedido está cancelado
  bool get isCancelled {
    return status == OrderStatus.cancelled;
  }

  /// Obtiene el total formateado en pesos dominicanos
  String get formattedTotal => 'RD\$${total.toStringAsFixed(2)}';

  /// Obtiene el subtotal formateado
  String get formattedSubtotal => 'RD\$${subtotal.toStringAsFixed(2)}';

  /// Obtiene el costo de delivery formateado
  String get formattedDeliveryFee => 'RD\$${deliveryFee.toStringAsFixed(2)}';

  /// Obtiene el tiempo transcurrido desde la creación
  Duration get timeElapsed => DateTime.now().difference(createdAt);

  /// Obtiene el tiempo transcurrido formateado
  String get formattedTimeElapsed {
    final elapsed = timeElapsed;
    if (elapsed.inHours > 0) {
      return '${elapsed.inHours}h ${elapsed.inMinutes % 60}m';
    } else {
      return '${elapsed.inMinutes}m';
    }
  }

  /// Obtiene el tiempo estimado de entrega formateado
  String get formattedEstimatedDelivery {
    if (estimatedDeliveryTime == null) return 'No estimado';
    if (estimatedDeliveryTime! >= 60) {
      final hours = estimatedDeliveryTime! ~/ 60;
      final minutes = estimatedDeliveryTime! % 60;
      return '${hours}h ${minutes}m';
    }
    return '${estimatedDeliveryTime}m';
  }

  /// Actualiza el estado del pedido
  Order updateStatus(OrderStatus newStatus) {
    final now = DateTime.now();
    return copyWith(
      status: newStatus,
      updatedAt: now,
      deliveredAt: newStatus == OrderStatus.delivered ? now : deliveredAt,
    );
  }

  /// Asigna un repartidor al pedido
  Order assignDeliveryPerson(String deliveryPersonId) {
    return copyWith(
      deliveryPersonId: deliveryPersonId,
      updatedAt: DateTime.now(),
    );
  }

  /// Marca el pedido como pagado
  Order markAsPaid() {
    return copyWith(
      isPaid: true,
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        storeId,
        status,
        subtotal,
        deliveryFee,
        total,
        paymentMethod,
        isPaid,
        deliveryAddress,
        deliveryLatitude,
        deliveryLongitude,
        notes,
        estimatedDeliveryTime,
        deliveryPersonId,
        isPriority,
        createdAt,
        updatedAt,
        deliveredAt,
      ];

  @override
  String toString() {
    return 'Order(id: $id, status: ${status.displayName}, total: $formattedTotal)';
  }
}

/// Entidad que representa un item dentro de un pedido
class OrderItem extends Equatable {
  /// ID único del item (UUID)
  final String id;
  
  /// ID del pedido al que pertenece
  final String orderId;
  
  /// ID del producto
  final String productId;
  
  /// Nombre del producto (snapshot al momento del pedido)
  final String productName;
  
  /// Precio unitario del producto (snapshot al momento del pedido)
  final double unitPrice;
  
  /// Cantidad solicitada
  final int quantity;
  
  /// Precio total del item (unitPrice * quantity)
  final double totalPrice;
  
  /// URL de la imagen del producto (snapshot)
  final String? productImageUrl;

  const OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    this.productImageUrl,
  });

  /// Crea una copia del item con campos actualizados
  OrderItem copyWith({
    String? id,
    String? orderId,
    String? productId,
    String? productName,
    double? unitPrice,
    int? quantity,
    double? totalPrice,
    String? productImageUrl,
  }) {
    return OrderItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      productImageUrl: productImageUrl ?? this.productImageUrl,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'unit_price': unitPrice,
      'quantity': quantity,
      'total_price': totalPrice,
      'product_image_url': productImageUrl,
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      unitPrice: (json['unit_price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      totalPrice: (json['total_price'] as num).toDouble(),
      productImageUrl: json['product_image_url'] as String?,
    );
  }

  /// Obtiene el precio unitario formateado
  String get formattedUnitPrice => 'RD\$${unitPrice.toStringAsFixed(2)}';

  /// Obtiene el precio total formateado
  String get formattedTotalPrice => 'RD\$${totalPrice.toStringAsFixed(2)}';

  /// Actualiza la cantidad y recalcula el precio total
  OrderItem updateQuantity(int newQuantity) {
    if (newQuantity <= 0) {
      throw ArgumentError('La cantidad debe ser mayor a 0');
    }
    return copyWith(
      quantity: newQuantity,
      totalPrice: unitPrice * newQuantity,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        productName,
        unitPrice,
        quantity,
        totalPrice,
        productImageUrl,
      ];

  @override
  String toString() {
    return 'OrderItem(productName: $productName, quantity: $quantity, total: $formattedTotalPrice)';
  }
}