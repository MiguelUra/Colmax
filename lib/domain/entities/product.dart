import 'package:equatable/equatable.dart';

/// Entidad que representa un producto en un colmado
class Product extends Equatable {
  /// ID único del producto (UUID)
  final String id;
  
  /// ID del colmado al que pertenece el producto
  final String storeId;
  
  /// ID de la categoría del producto (opcional)
  final String? categoryId;
  
  /// Nombre del producto
  final String name;
  
  /// Descripción del producto (opcional)
  final String? description;
  
  /// Precio de venta en RD$
  final double price;
  
  /// Precio de costo en RD$ (para cálculos de ganancia)
  final double? costPrice;
  
  /// Cantidad en stock
  final int stockQuantity;
  
  /// Cantidad mínima para alerta de stock bajo
  final int minStockAlert;
  
  /// URL de la imagen del producto (opcional)
  final String? imageUrl;
  
  /// Código de barras del producto (opcional)
  final String? barcode;
  
  /// Indica si el producto está activo
  final bool isActive;
  
  /// Indica si el producto está destacado
  final bool isFeatured;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.storeId,
    this.categoryId,
    required this.name,
    this.description,
    required this.price,
    this.costPrice,
    this.stockQuantity = 0,
    this.minStockAlert = 5,
    this.imageUrl,
    this.barcode,
    this.isActive = true,
    this.isFeatured = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Crea una copia del producto con campos actualizados
  Product copyWith({
    String? id,
    String? storeId,
    String? categoryId,
    String? name,
    String? description,
    double? price,
    double? costPrice,
    int? stockQuantity,
    int? minStockAlert,
    String? imageUrl,
    String? barcode,
    bool? isActive,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minStockAlert: minStockAlert ?? this.minStockAlert,
      imageUrl: imageUrl ?? this.imageUrl,
      barcode: barcode ?? this.barcode,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'cost_price': costPrice,
      'stock_quantity': stockQuantity,
      'min_stock_alert': minStockAlert,
      'image_url': imageUrl,
      'barcode': barcode,
      'is_active': isActive,
      'is_featured': isFeatured,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      categoryId: json['category_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      costPrice: (json['cost_price'] as num?)?.toDouble(),
      stockQuantity: json['stock_quantity'] as int? ?? 0,
      minStockAlert: json['min_stock_alert'] as int? ?? 5,
      imageUrl: json['image_url'] as String?,
      barcode: json['barcode'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      isFeatured: json['is_featured'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Verifica si el producto está disponible (activo y con stock)
  bool get isAvailable => isActive && stockQuantity > 0;

  /// Verifica si el stock está bajo
  bool get isLowStock => stockQuantity <= minStockAlert;

  /// Verifica si el producto está agotado
  bool get isOutOfStock => stockQuantity <= 0;

  /// Obtiene el precio formateado en pesos dominicanos
  String get formattedPrice => 'RD\$${price.toStringAsFixed(2)}';

  /// Obtiene el texto de disponibilidad
  String get availabilityText {
    if (isOutOfStock) return 'Agotado';
    if (isLowStock) return 'Pocas unidades';
    return 'Disponible';
  }

  /// Obtiene el margen de ganancia si se conoce el precio de costo
  double? get profitMargin {
    if (costPrice == null || costPrice! <= 0) return null;
    return ((price - costPrice!) / costPrice!) * 100;
  }

  /// Obtiene el margen de ganancia formateado
  String get formattedProfitMargin {
    final margin = profitMargin;
    if (margin == null) return 'N/A';
    return '${margin.toStringAsFixed(1)}%';
  }

  /// Calcula el precio total para una cantidad específica
  double calculateTotalPrice(int quantity) {
    return price * quantity;
  }

  /// Obtiene el precio total formateado para una cantidad específica
  String getFormattedTotalPrice(int quantity) {
    final total = calculateTotalPrice(quantity);
    return 'RD\$${total.toStringAsFixed(2)}';
  }

  /// Verifica si hay suficiente stock para una cantidad solicitada
  bool hasEnoughStock(int requestedQuantity) {
    return stockQuantity >= requestedQuantity;
  }

  /// Reduce el stock del producto
  Product reduceStock(int quantity) {
    if (quantity <= 0) return this;
    final newStock = (stockQuantity - quantity).clamp(0, stockQuantity);
    return copyWith(
      stockQuantity: newStock,
      updatedAt: DateTime.now(),
    );
  }

  /// Aumenta el stock del producto
  Product increaseStock(int quantity) {
    if (quantity <= 0) return this;
    return copyWith(
      stockQuantity: stockQuantity + quantity,
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        storeId,
        categoryId,
        name,
        description,
        price,
        costPrice,
        stockQuantity,
        minStockAlert,
        imageUrl,
        barcode,
        isActive,
        isFeatured,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $formattedPrice, stock: $stockQuantity)';
  }
}

/// Entidad que representa una categoría de productos
class ProductCategory extends Equatable {
  /// ID único de la categoría (UUID)
  final String id;
  
  /// Nombre de la categoría
  final String name;
  
  /// Descripción de la categoría (opcional)
  final String? description;
  
  /// Nombre del icono para la UI (opcional)
  final String? iconName;
  
  /// Indica si la categoría está activa
  final bool isActive;
  
  /// Fecha de creación
  final DateTime createdAt;

  const ProductCategory({
    required this.id,
    required this.name,
    this.description,
    this.iconName,
    this.isActive = true,
    required this.createdAt,
  });

  /// Crea una copia de la categoría con campos actualizados
  ProductCategory copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon_name': iconName,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      iconName: json['icon_name'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        iconName,
        isActive,
        createdAt,
      ];

  @override
  String toString() {
    return 'ProductCategory(id: $id, name: $name)';
  }
}