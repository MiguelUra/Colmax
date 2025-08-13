import 'package:equatable/equatable.dart';

/// Enumeración para los estados de entrega
enum DeliveryStatus {
  pending,    // Pendiente
  assigned,   // Asignado
  inProgress, // En progreso
  completed,  // Completado
  cancelled,  // Cancelado
}

/// Extensión para obtener texto legible de DeliveryStatus
extension DeliveryStatusExtension on DeliveryStatus {
  String get displayName {
    switch (this) {
      case DeliveryStatus.pending:
        return 'Pendiente';
      case DeliveryStatus.assigned:
        return 'Asignado';
      case DeliveryStatus.inProgress:
        return 'En progreso';
      case DeliveryStatus.completed:
        return 'Completado';
      case DeliveryStatus.cancelled:
        return 'Cancelado';
    }
  }

  String get dbValue {
    switch (this) {
      case DeliveryStatus.pending:
        return 'pending';
      case DeliveryStatus.assigned:
        return 'assigned';
      case DeliveryStatus.inProgress:
        return 'in_progress';
      case DeliveryStatus.completed:
        return 'completed';
      case DeliveryStatus.cancelled:
        return 'cancelled';
    }
  }

  static DeliveryStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return DeliveryStatus.pending;
      case 'assigned':
        return DeliveryStatus.assigned;
      case 'in_progress':
        return DeliveryStatus.inProgress;
      case 'completed':
        return DeliveryStatus.completed;
      case 'cancelled':
        return DeliveryStatus.cancelled;
      default:
        return DeliveryStatus.pending;
    }
  }
}

/// Entidad que representa una entrega
class Delivery extends Equatable {
  /// ID único de la entrega (UUID)
  final String id;
  
  /// ID del pedido asociado
  final String orderId;
  
  /// ID del repartidor asignado
  final String deliveryPersonId;
  
  /// Estado actual de la entrega
  final DeliveryStatus status;
  
  /// Dirección de recogida (colmado)
  final String pickupAddress;
  
  /// Latitud de la dirección de recogida
  final double pickupLatitude;
  
  /// Longitud de la dirección de recogida
  final double pickupLongitude;
  
  /// Dirección de entrega (cliente)
  final String deliveryAddress;
  
  /// Latitud de la dirección de entrega
  final double deliveryLatitude;
  
  /// Longitud de la dirección de entrega
  final double deliveryLongitude;
  
  /// Distancia estimada en kilómetros
  final double? estimatedDistance;
  
  /// Tiempo estimado de entrega en minutos
  final int? estimatedTime;
  
  /// Notas especiales para el repartidor
  final String? notes;
  
  /// Fecha de asignación
  final DateTime? assignedAt;
  
  /// Fecha de inicio de entrega
  final DateTime? startedAt;
  
  /// Fecha de finalización
  final DateTime? completedAt;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;

  const Delivery({
    required this.id,
    required this.orderId,
    required this.deliveryPersonId,
    this.status = DeliveryStatus.pending,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.deliveryAddress,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    this.estimatedDistance,
    this.estimatedTime,
    this.notes,
    this.assignedAt,
    this.startedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Crea una copia de la entrega con campos actualizados
  Delivery copyWith({
    String? id,
    String? orderId,
    String? deliveryPersonId,
    DeliveryStatus? status,
    String? pickupAddress,
    double? pickupLatitude,
    double? pickupLongitude,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    double? estimatedDistance,
    int? estimatedTime,
    String? notes,
    DateTime? assignedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Delivery(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      deliveryPersonId: deliveryPersonId ?? this.deliveryPersonId,
      status: status ?? this.status,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
      estimatedDistance: estimatedDistance ?? this.estimatedDistance,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      notes: notes ?? this.notes,
      assignedAt: assignedAt ?? this.assignedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'delivery_person_id': deliveryPersonId,
      'status': status.dbValue,
      'pickup_address': pickupAddress,
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'delivery_address': deliveryAddress,
      'delivery_latitude': deliveryLatitude,
      'delivery_longitude': deliveryLongitude,
      'estimated_distance': estimatedDistance,
      'estimated_time': estimatedTime,
      'notes': notes,
      'assigned_at': assignedAt?.toIso8601String(),
      'started_at': startedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      deliveryPersonId: json['delivery_person_id'] as String,
      status: DeliveryStatusExtension.fromString(json['status'] as String),
      pickupAddress: json['pickup_address'] as String,
      pickupLatitude: (json['pickup_latitude'] as num).toDouble(),
      pickupLongitude: (json['pickup_longitude'] as num).toDouble(),
      deliveryAddress: json['delivery_address'] as String,
      deliveryLatitude: (json['delivery_latitude'] as num).toDouble(),
      deliveryLongitude: (json['delivery_longitude'] as num).toDouble(),
      estimatedDistance: (json['estimated_distance'] as num?)?.toDouble(),
      estimatedTime: json['estimated_time'] as int?,
      notes: json['notes'] as String?,
      assignedAt: json['assigned_at'] != null 
          ? DateTime.parse(json['assigned_at'] as String) 
          : null,
      startedAt: json['started_at'] != null 
          ? DateTime.parse(json['started_at'] as String) 
          : null,
      completedAt: json['completed_at'] != null 
          ? DateTime.parse(json['completed_at'] as String) 
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Verifica si la entrega está en progreso
  bool get isInProgress {
    return status == DeliveryStatus.assigned || status == DeliveryStatus.inProgress;
  }

  /// Verifica si la entrega está completada
  bool get isCompleted {
    return status == DeliveryStatus.completed;
  }

  /// Verifica si la entrega está cancelada
  bool get isCancelled {
    return status == DeliveryStatus.cancelled;
  }

  /// Obtiene la distancia formateada
  String get formattedDistance {
    if (estimatedDistance == null) return 'No calculada';
    return '${estimatedDistance!.toStringAsFixed(1)} km';
  }

  /// Obtiene el tiempo estimado formateado
  String get formattedEstimatedTime {
    if (estimatedTime == null) return 'No estimado';
    if (estimatedTime! >= 60) {
      final hours = estimatedTime! ~/ 60;
      final minutes = estimatedTime! % 60;
      return '${hours}h ${minutes}m';
    }
    return '${estimatedTime}m';
  }

  /// Obtiene el tiempo transcurrido desde la asignación
  Duration? get timeElapsedSinceAssignment {
    if (assignedAt == null) return null;
    return DateTime.now().difference(assignedAt!);
  }

  /// Obtiene el tiempo transcurrido desde el inicio
  Duration? get timeElapsedSinceStart {
    if (startedAt == null) return null;
    return DateTime.now().difference(startedAt!);
  }

  /// Asigna la entrega a un repartidor
  Delivery assign() {
    final now = DateTime.now();
    return copyWith(
      status: DeliveryStatus.assigned,
      assignedAt: now,
      updatedAt: now,
    );
  }

  /// Inicia la entrega
  Delivery start() {
    final now = DateTime.now();
    return copyWith(
      status: DeliveryStatus.inProgress,
      startedAt: now,
      updatedAt: now,
    );
  }

  /// Completa la entrega
  Delivery complete() {
    final now = DateTime.now();
    return copyWith(
      status: DeliveryStatus.completed,
      completedAt: now,
      updatedAt: now,
    );
  }

  /// Cancela la entrega
  Delivery cancel() {
    return copyWith(
      status: DeliveryStatus.cancelled,
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        deliveryPersonId,
        status,
        pickupAddress,
        pickupLatitude,
        pickupLongitude,
        deliveryAddress,
        deliveryLatitude,
        deliveryLongitude,
        estimatedDistance,
        estimatedTime,
        notes,
        assignedAt,
        startedAt,
        completedAt,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'Delivery(id: $id, status: ${status.displayName}, distance: $formattedDistance)';
  }
}

/// Entidad que representa una ruta de entrega optimizada
class DeliveryRoute extends Equatable {
  /// ID único de la ruta (UUID)
  final String id;
  
  /// ID del repartidor asignado
  final String deliveryPersonId;
  
  /// Lista de IDs de pedidos en orden de entrega
  final List<String> orderIds;
  
  /// Distancia total estimada en kilómetros
  final double totalDistance;
  
  /// Tiempo total estimado en minutos
  final int totalEstimatedTime;
  
  /// Indica si la ruta está activa
  final bool isActive;
  
  /// Fecha de creación de la ruta
  final DateTime createdAt;
  
  /// Fecha de finalización (cuando se completa)
  final DateTime? completedAt;

  const DeliveryRoute({
    required this.id,
    required this.deliveryPersonId,
    required this.orderIds,
    required this.totalDistance,
    required this.totalEstimatedTime,
    this.isActive = true,
    required this.createdAt,
    this.completedAt,
  });

  /// Crea una copia de la ruta con campos actualizados
  DeliveryRoute copyWith({
    String? id,
    String? deliveryPersonId,
    List<String>? orderIds,
    double? totalDistance,
    int? totalEstimatedTime,
    bool? isActive,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return DeliveryRoute(
      id: id ?? this.id,
      deliveryPersonId: deliveryPersonId ?? this.deliveryPersonId,
      orderIds: orderIds ?? this.orderIds,
      totalDistance: totalDistance ?? this.totalDistance,
      totalEstimatedTime: totalEstimatedTime ?? this.totalEstimatedTime,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'delivery_person_id': deliveryPersonId,
      'order_ids': orderIds,
      'total_distance': totalDistance,
      'total_estimated_time': totalEstimatedTime,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory DeliveryRoute.fromJson(Map<String, dynamic> json) {
    return DeliveryRoute(
      id: json['id'] as String,
      deliveryPersonId: json['delivery_person_id'] as String,
      orderIds: List<String>.from(json['order_ids'] as List),
      totalDistance: (json['total_distance'] as num).toDouble(),
      totalEstimatedTime: json['total_estimated_time'] as int,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      completedAt: json['completed_at'] != null 
          ? DateTime.parse(json['completed_at'] as String) 
          : null,
    );
  }

  /// Verifica si la ruta está completada
  bool get isCompleted => completedAt != null;

  /// Obtiene el número de pedidos en la ruta
  int get orderCount => orderIds.length;

  /// Obtiene la distancia total formateada
  String get formattedTotalDistance => '${totalDistance.toStringAsFixed(1)} km';

  /// Obtiene el tiempo total estimado formateado
  String get formattedTotalTime {
    if (totalEstimatedTime >= 60) {
      final hours = totalEstimatedTime ~/ 60;
      final minutes = totalEstimatedTime % 60;
      return '${hours}h ${minutes}m';
    }
    return '${totalEstimatedTime}m';
  }

  /// Completa la ruta
  DeliveryRoute complete() {
    return copyWith(
      isActive: false,
      completedAt: DateTime.now(),
    );
  }

  /// Remueve un pedido de la ruta
  DeliveryRoute removeOrder(String orderId) {
    final newOrderIds = List<String>.from(orderIds);
    newOrderIds.remove(orderId);
    return copyWith(orderIds: newOrderIds);
  }

  /// Agrega un pedido a la ruta
  DeliveryRoute addOrder(String orderId) {
    if (orderIds.contains(orderId)) return this;
    final newOrderIds = List<String>.from(orderIds);
    newOrderIds.add(orderId);
    return copyWith(orderIds: newOrderIds);
  }

  @override
  List<Object?> get props => [
        id,
        deliveryPersonId,
        orderIds,
        totalDistance,
        totalEstimatedTime,
        isActive,
        createdAt,
        completedAt,
      ];

  @override
  String toString() {
    return 'DeliveryRoute(id: $id, orders: $orderCount, distance: $formattedTotalDistance)';
  }
}

/// Entidad que representa la ubicación actual de un repartidor
class DeliveryPersonLocation extends Equatable {
  /// ID del repartidor
  final String deliveryPersonId;
  
  /// Latitud actual
  final double latitude;
  
  /// Longitud actual
  final double longitude;
  
  /// Precisión de la ubicación en metros
  final double? accuracy;
  
  /// Velocidad en m/s (opcional)
  final double? speed;
  
  /// Dirección en grados (opcional)
  final double? heading;
  
  /// Timestamp de la ubicación
  final DateTime timestamp;

  const DeliveryPersonLocation({
    required this.deliveryPersonId,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.speed,
    this.heading,
    required this.timestamp,
  });

  /// Crea una copia de la ubicación con campos actualizados
  DeliveryPersonLocation copyWith({
    String? deliveryPersonId,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? speed,
    double? heading,
    DateTime? timestamp,
  }) {
    return DeliveryPersonLocation(
      deliveryPersonId: deliveryPersonId ?? this.deliveryPersonId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      speed: speed ?? this.speed,
      heading: heading ?? this.heading,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'delivery_person_id': deliveryPersonId,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'speed': speed,
      'heading': heading,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory DeliveryPersonLocation.fromJson(Map<String, dynamic> json) {
    return DeliveryPersonLocation(
      deliveryPersonId: json['delivery_person_id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
      heading: (json['heading'] as num?)?.toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Verifica si la ubicación es reciente (menos de 5 minutos)
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    return difference.inMinutes < 5;
  }

  /// Obtiene la velocidad formateada en km/h
  String get formattedSpeed {
    if (speed == null) return 'N/A';
    final kmh = speed! * 3.6; // Convertir m/s a km/h
    return '${kmh.toStringAsFixed(1)} km/h';
  }

  /// Obtiene la precisión formateada
  String get formattedAccuracy {
    if (accuracy == null) return 'N/A';
    return '±${accuracy!.toStringAsFixed(0)}m';
  }

  @override
  List<Object?> get props => [
        deliveryPersonId,
        latitude,
        longitude,
        accuracy,
        speed,
        heading,
        timestamp,
      ];

  @override
  String toString() {
    return 'DeliveryPersonLocation(id: $deliveryPersonId, lat: $latitude, lng: $longitude)';
  }
}