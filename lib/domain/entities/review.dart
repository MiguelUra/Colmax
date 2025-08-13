import 'package:equatable/equatable.dart';

/// Entidad que representa una reseña de un colmado
class Review extends Equatable {
  /// ID único de la reseña (UUID)
  final String id;
  
  /// ID del usuario que escribió la reseña
  final String userId;
  
  /// ID del colmado reseñado
  final String storeId;
  
  /// ID del pedido asociado (opcional)
  final String? orderId;
  
  /// Calificación de 1 a 5 estrellas
  final int rating;
  
  /// Comentario de la reseña (opcional)
  final String? comment;
  
  /// Calificación específica para la calidad del producto (1-5)
  final int? productQualityRating;
  
  /// Calificación específica para el servicio (1-5)
  final int? serviceRating;
  
  /// Calificación específica para la velocidad de entrega (1-5)
  final int? deliverySpeedRating;
  
  /// Lista de URLs de imágenes adjuntas (opcional)
  final List<String> imageUrls;
  
  /// Indica si la reseña ha sido verificada
  final bool isVerified;
  
  /// Indica si la reseña está oculta/reportada
  final bool isHidden;
  
  /// Respuesta del dueño del colmado (opcional)
  final String? ownerResponse;
  
  /// Fecha de la respuesta del dueño (opcional)
  final DateTime? ownerResponseDate;
  
  /// Número de "me gusta" recibidos
  final int likesCount;
  
  /// Número de reportes recibidos
  final int reportsCount;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;

  const Review({
    required this.id,
    required this.userId,
    required this.storeId,
    this.orderId,
    required this.rating,
    this.comment,
    this.productQualityRating,
    this.serviceRating,
    this.deliverySpeedRating,
    this.imageUrls = const [],
    this.isVerified = false,
    this.isHidden = false,
    this.ownerResponse,
    this.ownerResponseDate,
    this.likesCount = 0,
    this.reportsCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Crea una copia de la reseña con campos actualizados
  Review copyWith({
    String? id,
    String? userId,
    String? storeId,
    String? orderId,
    int? rating,
    String? comment,
    int? productQualityRating,
    int? serviceRating,
    int? deliverySpeedRating,
    List<String>? imageUrls,
    bool? isVerified,
    bool? isHidden,
    String? ownerResponse,
    DateTime? ownerResponseDate,
    int? likesCount,
    int? reportsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      storeId: storeId ?? this.storeId,
      orderId: orderId ?? this.orderId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      productQualityRating: productQualityRating ?? this.productQualityRating,
      serviceRating: serviceRating ?? this.serviceRating,
      deliverySpeedRating: deliverySpeedRating ?? this.deliverySpeedRating,
      imageUrls: imageUrls ?? this.imageUrls,
      isVerified: isVerified ?? this.isVerified,
      isHidden: isHidden ?? this.isHidden,
      ownerResponse: ownerResponse ?? this.ownerResponse,
      ownerResponseDate: ownerResponseDate ?? this.ownerResponseDate,
      likesCount: likesCount ?? this.likesCount,
      reportsCount: reportsCount ?? this.reportsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'store_id': storeId,
      'order_id': orderId,
      'rating': rating,
      'comment': comment,
      'product_quality_rating': productQualityRating,
      'service_rating': serviceRating,
      'delivery_speed_rating': deliverySpeedRating,
      'image_urls': imageUrls,
      'is_verified': isVerified,
      'is_hidden': isHidden,
      'owner_response': ownerResponse,
      'owner_response_date': ownerResponseDate?.toIso8601String(),
      'likes_count': likesCount,
      'reports_count': reportsCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      storeId: json['store_id'] as String,
      orderId: json['order_id'] as String?,
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
      productQualityRating: json['product_quality_rating'] as int?,
      serviceRating: json['service_rating'] as int?,
      deliverySpeedRating: json['delivery_speed_rating'] as int?,
      imageUrls: List<String>.from(json['image_urls'] as List? ?? []),
      isVerified: json['is_verified'] as bool? ?? false,
      isHidden: json['is_hidden'] as bool? ?? false,
      ownerResponse: json['owner_response'] as String?,
      ownerResponseDate: json['owner_response_date'] != null 
          ? DateTime.parse(json['owner_response_date'] as String) 
          : null,
      likesCount: json['likes_count'] as int? ?? 0,
      reportsCount: json['reports_count'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Verifica si la reseña es válida (rating entre 1 y 5)
  bool get isValid => rating >= 1 && rating <= 5;

  /// Verifica si la reseña tiene comentario
  bool get hasComment => comment != null && comment!.trim().isNotEmpty;

  /// Verifica si la reseña tiene imágenes
  bool get hasImages => imageUrls.isNotEmpty;

  /// Verifica si el dueño ha respondido
  bool get hasOwnerResponse => ownerResponse != null && ownerResponse!.trim().isNotEmpty;

  /// Verifica si la reseña es reciente (menos de 7 días)
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inDays < 7;
  }

  /// Verifica si la reseña es positiva (4-5 estrellas)
  bool get isPositive => rating >= 4;

  /// Verifica si la reseña es negativa (1-2 estrellas)
  bool get isNegative => rating <= 2;

  /// Verifica si la reseña es neutral (3 estrellas)
  bool get isNeutral => rating == 3;

  /// Obtiene el texto descriptivo del rating
  String get ratingText {
    switch (rating) {
      case 1:
        return 'Muy malo';
      case 2:
        return 'Malo';
      case 3:
        return 'Regular';
      case 4:
        return 'Bueno';
      case 5:
        return 'Excelente';
      default:
        return 'Sin calificar';
    }
  }

  /// Obtiene las estrellas como string visual
  String get starsDisplay {
    return '★' * rating + '☆' * (5 - rating);
  }

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

  /// Obtiene el promedio de las calificaciones específicas
  double? get averageSpecificRating {
    final ratings = [
      productQualityRating,
      serviceRating,
      deliverySpeedRating,
    ].where((r) => r != null).cast<int>().toList();
    
    if (ratings.isEmpty) return null;
    
    final sum = ratings.reduce((a, b) => a + b);
    return sum / ratings.length;
  }

  /// Obtiene el promedio de calificaciones específicas formateado
  String get formattedAverageSpecificRating {
    final avg = averageSpecificRating;
    if (avg == null) return 'N/A';
    return avg.toStringAsFixed(1);
  }

  /// Incrementa el contador de "me gusta"
  Review incrementLikes() {
    return copyWith(
      likesCount: likesCount + 1,
      updatedAt: DateTime.now(),
    );
  }

  /// Decrementa el contador de "me gusta"
  Review decrementLikes() {
    return copyWith(
      likesCount: (likesCount - 1).clamp(0, likesCount),
      updatedAt: DateTime.now(),
    );
  }

  /// Incrementa el contador de reportes
  Review incrementReports() {
    return copyWith(
      reportsCount: reportsCount + 1,
      updatedAt: DateTime.now(),
    );
  }

  /// Marca la reseña como verificada
  Review verify() {
    return copyWith(
      isVerified: true,
      updatedAt: DateTime.now(),
    );
  }

  /// Oculta la reseña
  Review hide() {
    return copyWith(
      isHidden: true,
      updatedAt: DateTime.now(),
    );
  }

  /// Muestra la reseña
  Review show() {
    return copyWith(
      isHidden: false,
      updatedAt: DateTime.now(),
    );
  }

  /// Agrega respuesta del dueño
  Review addOwnerResponse(String response) {
    final now = DateTime.now();
    return copyWith(
      ownerResponse: response,
      ownerResponseDate: now,
      updatedAt: now,
    );
  }

  /// Remueve la respuesta del dueño
  Review removeOwnerResponse() {
    return copyWith(
      ownerResponse: null,
      ownerResponseDate: null,
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        storeId,
        orderId,
        rating,
        comment,
        productQualityRating,
        serviceRating,
        deliverySpeedRating,
        imageUrls,
        isVerified,
        isHidden,
        ownerResponse,
        ownerResponseDate,
        likesCount,
        reportsCount,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'Review(id: $id, rating: $rating, comment: ${comment?.substring(0, comment!.length.clamp(0, 50))}...)';
  }
}

/// Entidad que representa estadísticas de reseñas de un colmado
class ReviewStats extends Equatable {
  /// ID del colmado
  final String storeId;
  
  /// Número total de reseñas
  final int totalReviews;
  
  /// Calificación promedio
  final double averageRating;
  
  /// Número de reseñas de 5 estrellas
  final int fiveStarCount;
  
  /// Número de reseñas de 4 estrellas
  final int fourStarCount;
  
  /// Número de reseñas de 3 estrellas
  final int threeStarCount;
  
  /// Número de reseñas de 2 estrellas
  final int twoStarCount;
  
  /// Número de reseñas de 1 estrella
  final int oneStarCount;
  
  /// Promedio de calificación de calidad de producto
  final double? averageProductQuality;
  
  /// Promedio de calificación de servicio
  final double? averageService;
  
  /// Promedio de calificación de velocidad de entrega
  final double? averageDeliverySpeed;
  
  /// Fecha de última actualización
  final DateTime updatedAt;

  const ReviewStats({
    required this.storeId,
    this.totalReviews = 0,
    this.averageRating = 0.0,
    this.fiveStarCount = 0,
    this.fourStarCount = 0,
    this.threeStarCount = 0,
    this.twoStarCount = 0,
    this.oneStarCount = 0,
    this.averageProductQuality,
    this.averageService,
    this.averageDeliverySpeed,
    required this.updatedAt,
  });

  /// Crea una copia de las estadísticas con campos actualizados
  ReviewStats copyWith({
    String? storeId,
    int? totalReviews,
    double? averageRating,
    int? fiveStarCount,
    int? fourStarCount,
    int? threeStarCount,
    int? twoStarCount,
    int? oneStarCount,
    double? averageProductQuality,
    double? averageService,
    double? averageDeliverySpeed,
    DateTime? updatedAt,
  }) {
    return ReviewStats(
      storeId: storeId ?? this.storeId,
      totalReviews: totalReviews ?? this.totalReviews,
      averageRating: averageRating ?? this.averageRating,
      fiveStarCount: fiveStarCount ?? this.fiveStarCount,
      fourStarCount: fourStarCount ?? this.fourStarCount,
      threeStarCount: threeStarCount ?? this.threeStarCount,
      twoStarCount: twoStarCount ?? this.twoStarCount,
      oneStarCount: oneStarCount ?? this.oneStarCount,
      averageProductQuality: averageProductQuality ?? this.averageProductQuality,
      averageService: averageService ?? this.averageService,
      averageDeliverySpeed: averageDeliverySpeed ?? this.averageDeliverySpeed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'total_reviews': totalReviews,
      'average_rating': averageRating,
      'five_star_count': fiveStarCount,
      'four_star_count': fourStarCount,
      'three_star_count': threeStarCount,
      'two_star_count': twoStarCount,
      'one_star_count': oneStarCount,
      'average_product_quality': averageProductQuality,
      'average_service': averageService,
      'average_delivery_speed': averageDeliverySpeed,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory ReviewStats.fromJson(Map<String, dynamic> json) {
    return ReviewStats(
      storeId: json['store_id'] as String,
      totalReviews: json['total_reviews'] as int? ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      fiveStarCount: json['five_star_count'] as int? ?? 0,
      fourStarCount: json['four_star_count'] as int? ?? 0,
      threeStarCount: json['three_star_count'] as int? ?? 0,
      twoStarCount: json['two_star_count'] as int? ?? 0,
      oneStarCount: json['one_star_count'] as int? ?? 0,
      averageProductQuality: (json['average_product_quality'] as num?)?.toDouble(),
      averageService: (json['average_service'] as num?)?.toDouble(),
      averageDeliverySpeed: (json['average_delivery_speed'] as num?)?.toDouble(),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Obtiene la calificación promedio formateada
  String get formattedAverageRating => averageRating.toStringAsFixed(1);

  /// Obtiene las estrellas como string visual
  String get starsDisplay {
    final fullStars = averageRating.floor();
    final hasHalfStar = (averageRating - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    
    return '★' * fullStars + 
           (hasHalfStar ? '☆' : '') + 
           '☆' * emptyStars;
  }

  /// Obtiene el porcentaje de reseñas positivas (4-5 estrellas)
  double get positivePercentage {
    if (totalReviews == 0) return 0.0;
    return ((fourStarCount + fiveStarCount) / totalReviews) * 100;
  }

  /// Obtiene el porcentaje de reseñas negativas (1-2 estrellas)
  double get negativePercentage {
    if (totalReviews == 0) return 0.0;
    return ((oneStarCount + twoStarCount) / totalReviews) * 100;
  }

  /// Obtiene el porcentaje para cada nivel de estrellas
  Map<int, double> get starPercentages {
    if (totalReviews == 0) {
      return {1: 0.0, 2: 0.0, 3: 0.0, 4: 0.0, 5: 0.0};
    }
    
    return {
      1: (oneStarCount / totalReviews) * 100,
      2: (twoStarCount / totalReviews) * 100,
      3: (threeStarCount / totalReviews) * 100,
      4: (fourStarCount / totalReviews) * 100,
      5: (fiveStarCount / totalReviews) * 100,
    };
  }

  /// Verifica si tiene suficientes reseñas para ser confiable
  bool get hasReliableRating => totalReviews >= 5;

  /// Obtiene el texto descriptivo del rating promedio
  String get averageRatingText {
    if (averageRating >= 4.5) return 'Excelente';
    if (averageRating >= 4.0) return 'Muy bueno';
    if (averageRating >= 3.5) return 'Bueno';
    if (averageRating >= 3.0) return 'Regular';
    if (averageRating >= 2.0) return 'Malo';
    return 'Muy malo';
  }

  @override
  List<Object?> get props => [
        storeId,
        totalReviews,
        averageRating,
        fiveStarCount,
        fourStarCount,
        threeStarCount,
        twoStarCount,
        oneStarCount,
        averageProductQuality,
        averageService,
        averageDeliverySpeed,
        updatedAt,
      ];

  @override
  String toString() {
    return 'ReviewStats(storeId: $storeId, total: $totalReviews, avg: $formattedAverageRating)';
  }
}