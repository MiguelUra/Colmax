import 'dart:math' as math;
import 'package:equatable/equatable.dart';

/// Entidad que representa un colmado/tienda en el sistema Colmax
class Store extends Equatable {
  /// ID único del colmado (UUID)
  final String id;
  
  /// ID del dueño del colmado
  final String ownerId;
  
  /// Nombre del colmado
  final String name;
  
  /// Descripción del colmado (opcional)
  final String? description;
  
  /// Dirección física del colmado
  final String address;
  
  /// Número de teléfono del colmado (opcional)
  final String? phone;
  
  /// Coordenadas de ubicación (latitud, longitud)
  final StoreLocation? location;
  
  /// URL de la imagen del colmado (opcional)
  final String? imageUrl;
  
  /// Indica si el colmado está activo
  final bool isActive;
  
  /// Indica si el colmado tiene suscripción premium (aparece primero)
  final bool isPremium;
  
  /// Calificación promedio del colmado (0.0 - 5.0)
  final double rating;
  
  /// Número total de reseñas
  final int totalReviews;
  
  /// Tarifa de entrega en RD$
  final double deliveryFee;
  
  /// Monto mínimo de pedido en RD$
  final double minOrderAmount;
  
  /// Tiempo estimado de entrega en minutos
  final int estimatedDeliveryTime;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;

  const Store({
    required this.id,
    required this.ownerId,
    required this.name,
    this.description,
    required this.address,
    this.phone,
    this.location,
    this.imageUrl,
    this.isActive = true,
    this.isPremium = false,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.deliveryFee = 50.0,
    this.minOrderAmount = 0.0,
    this.estimatedDeliveryTime = 30,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Crea una copia del colmado con campos actualizados
  Store copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? description,
    String? address,
    String? phone,
    StoreLocation? location,
    String? imageUrl,
    bool? isActive,
    bool? isPremium,
    double? rating,
    int? totalReviews,
    double? deliveryFee,
    double? minOrderAmount,
    int? estimatedDeliveryTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Store(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      isPremium: isPremium ?? this.isPremium,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minOrderAmount: minOrderAmount ?? this.minOrderAmount,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'location': location?.toJson(),
      'image_url': imageUrl,
      'is_active': isActive,
      'is_premium': isPremium,
      'rating': rating,
      'total_reviews': totalReviews,
      'delivery_fee': deliveryFee,
      'min_order_amount': minOrderAmount,
      'estimated_delivery_time': estimatedDeliveryTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      address: json['address'] as String,
      phone: json['phone'] as String?,
      location: json['location'] != null 
          ? StoreLocation.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      isPremium: json['is_premium'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['total_reviews'] as int? ?? 0,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 50.0,
      minOrderAmount: (json['min_order_amount'] as num?)?.toDouble() ?? 0.0,
      estimatedDeliveryTime: json['estimated_delivery_time'] as int? ?? 30,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Calcula la distancia desde una ubicación dada en kilómetros
  double? distanceFrom(double latitude, double longitude) {
    if (location == null) return null;
    return location!.distanceTo(latitude, longitude);
  }

  /// Verifica si el colmado está abierto (simplificado - siempre abierto por ahora)
  bool get isOpen => isActive;

  /// Obtiene el texto de calificación formateado
  String get ratingText {
    if (totalReviews == 0) return 'Sin calificaciones';
    return '${rating.toStringAsFixed(1)} (${totalReviews} reseñas)';
  }

  /// Obtiene el texto de tiempo de entrega formateado
  String get deliveryTimeText {
    return '${estimatedDeliveryTime} min';
  }

  /// Obtiene el texto de tarifa de entrega formateado
  String get deliveryFeeText {
    if (deliveryFee == 0) return 'Entrega gratis';
    return 'RD\$${deliveryFee.toStringAsFixed(0)}';
  }

  @override
  List<Object?> get props => [
        id,
        ownerId,
        name,
        description,
        address,
        phone,
        location,
        imageUrl,
        isActive,
        isPremium,
        rating,
        totalReviews,
        deliveryFee,
        minOrderAmount,
        estimatedDeliveryTime,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'Store(id: $id, name: $name, address: $address, rating: $rating)';
  }
}

/// Clase para representar la ubicación geográfica de un colmado
class StoreLocation extends Equatable {
  /// Latitud
  final double latitude;
  
  /// Longitud
  final double longitude;

  const StoreLocation({
    required this.latitude,
    required this.longitude,
  });

  /// Convierte a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  /// Crea desde Map (deserialización)
  factory StoreLocation.fromJson(Map<String, dynamic> json) {
    return StoreLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  /// Calcula la distancia a otra ubicación usando la fórmula de Haversine
  double distanceTo(double otherLatitude, double otherLongitude) {
    const double earthRadius = 6371; // Radio de la Tierra en km
    
    final double dLat = _toRadians(otherLatitude - latitude);
    final double dLon = _toRadians(otherLongitude - longitude);
    
    final double a = 
        (dLat / 2).sin() * (dLat / 2).sin() +
        latitude.toRadians().cos() * otherLatitude.toRadians().cos() *
        (dLon / 2).sin() * (dLon / 2).sin();
    
    final double c = 2 * (a.sqrt()).asin();
    
    return earthRadius * c;
  }

  /// Convierte grados a radianes
  double _toRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }

  @override
  List<Object?> get props => [latitude, longitude];

  @override
  String toString() {
    return 'StoreLocation(lat: $latitude, lng: $longitude)';
  }
}

/// Extensión para facilitar conversiones de grados a radianes
extension on double {
  double toRadians() => this * (3.14159265359 / 180);
  double sin() => math.sin(this);
  double cos() => math.cos(this);
  double asin() => math.asin(this);
  double sqrt() => math.sqrt(this);
}