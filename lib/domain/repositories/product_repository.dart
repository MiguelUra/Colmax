import '../entities/product.dart';

/// Repositorio abstracto para la gestión de productos
/// Define los contratos que debe implementar la capa de datos
abstract class ProductRepository {
  /// Obtiene todos los productos
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir para paginación
  Future<List<Product>> getAllProducts({int limit = 50, int offset = 0});
  
  /// Obtiene un producto por su ID
  /// Lanza excepción si el producto no existe
  Future<Product> getProductById(String productId);
  
  /// Obtiene múltiples productos por sus IDs
  Future<List<Product>> getProductsByIds(List<String> productIds);
  
  /// Obtiene productos de una tienda específica
  /// [storeId] - ID de la tienda
  /// [isActive] - Filtrar por estado activo (opcional)
  /// [inStock] - Filtrar por disponibilidad en stock (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Product>> getProductsByStore(
    String storeId, {
    bool? isActive,
    bool? inStock,
    int limit = 100,
    int offset = 0,
  });
  
  /// Obtiene productos por categoría
  /// [categoryId] - ID de la categoría
  /// [storeId] - ID de la tienda (opcional, para filtrar por tienda)
  /// [isActive] - Filtrar por estado activo
  /// [inStock] - Filtrar por disponibilidad en stock
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Product>> getProductsByCategory(
    String categoryId, {
    String? storeId,
    bool isActive = true,
    bool inStock = true,
    int limit = 50,
    int offset = 0,
  });
  
  /// Busca productos por nombre o descripción
  /// [query] - Término de búsqueda
  /// [storeId] - ID de la tienda (opcional, para filtrar por tienda)
  /// [categoryId] - ID de la categoría (opcional, para filtrar por categoría)
  /// [minPrice] - Precio mínimo (opcional)
  /// [maxPrice] - Precio máximo (opcional)
  /// [isActive] - Filtrar por estado activo
  /// [inStock] - Filtrar por disponibilidad en stock
  /// [limit] - Número máximo de resultados
  Future<List<Product>> searchProducts(
    String query, {
    String? storeId,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    bool isActive = true,
    bool inStock = true,
    int limit = 20,
  });
  
  /// Obtiene productos populares (más vendidos)
  /// [storeId] - ID de la tienda (opcional)
  /// [categoryId] - ID de la categoría (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Product>> getPopularProducts({
    String? storeId,
    String? categoryId,
    int limit = 10,
  });
  
  /// Obtiene productos en oferta
  /// [storeId] - ID de la tienda (opcional)
  /// [categoryId] - ID de la categoría (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Product>> getProductsOnSale({
    String? storeId,
    String? categoryId,
    int limit = 20,
  });
  
  /// Obtiene productos recomendados para un usuario
  /// [userId] - ID del usuario
  /// [storeId] - ID de la tienda (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Product>> getRecommendedProducts(
    String userId, {
    String? storeId,
    int limit = 10,
  });
  
  /// Obtiene productos relacionados
  /// [productId] - ID del producto de referencia
  /// [limit] - Número máximo de resultados
  Future<List<Product>> getRelatedProducts(
    String productId, {
    int limit = 5,
  });
  
  /// Crea un nuevo producto
  /// [product] - Datos del producto a crear
  Future<Product> createProduct(Product product);
  
  /// Actualiza un producto existente
  /// [productId] - ID del producto a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<Product> updateProduct(String productId, Map<String, dynamic> updates);
  
  /// Actualiza el stock de un producto
  /// [productId] - ID del producto
  /// [newStock] - Nuevo valor de stock
  Future<Product> updateProductStock(String productId, int newStock);
  
  /// Incrementa el stock de un producto
  /// [productId] - ID del producto
  /// [quantity] - Cantidad a incrementar
  Future<Product> incrementProductStock(String productId, int quantity);
  
  /// Decrementa el stock de un producto
  /// [productId] - ID del producto
  /// [quantity] - Cantidad a decrementar
  Future<Product> decrementProductStock(String productId, int quantity);
  
  /// Actualiza el precio de un producto
  /// [productId] - ID del producto
  /// [newPrice] - Nuevo precio
  /// [salePrice] - Nuevo precio de oferta (opcional)
  Future<Product> updateProductPrice(
    String productId,
    double newPrice, {
    double? salePrice,
  });
  
  /// Actualiza el estado activo de un producto
  /// [productId] - ID del producto
  /// [isActive] - Nuevo estado activo
  Future<Product> updateProductActiveStatus(String productId, bool isActive);
  
  /// Actualiza las imágenes de un producto
  /// [productId] - ID del producto
  /// [imageUrls] - Lista de URLs de imágenes
  Future<Product> updateProductImages(String productId, List<String> imageUrls);
  
  /// Sube una imagen para un producto
  /// [productId] - ID del producto
  /// [imageBytes] - Bytes de la imagen
  /// [fileName] - Nombre del archivo
  /// Retorna la URL de la imagen subida
  Future<String> uploadProductImage(
    String productId,
    List<int> imageBytes,
    String fileName,
  );
  
  /// Elimina una imagen de un producto
  /// [productId] - ID del producto
  /// [imageUrl] - URL de la imagen a eliminar
  Future<void> deleteProductImage(String productId, String imageUrl);
  
  /// Agrega una imagen a un producto
  /// [productId] - ID del producto
  /// [imageUrl] - URL de la imagen
  Future<Product> addProductImage(String productId, String imageUrl);
  
  /// Remueve una imagen de un producto
  /// [productId] - ID del producto
  /// [imageUrl] - URL de la imagen a remover
  Future<Product> removeProductImage(String productId, String imageUrl);
  
  /// Elimina un producto (soft delete)
  /// [productId] - ID del producto a eliminar
  Future<void> deleteProduct(String productId);
  
  /// Restaura un producto eliminado
  /// [productId] - ID del producto a restaurar
  Future<Product> restoreProduct(String productId);
  
  /// Obtiene productos con stock bajo
  /// [storeId] - ID de la tienda
  /// [threshold] - Umbral de stock bajo (por defecto 10)
  Future<List<Product>> getLowStockProducts(
    String storeId, {
    int threshold = 10,
  });
  
  /// Obtiene productos sin stock
  /// [storeId] - ID de la tienda
  Future<List<Product>> getOutOfStockProducts(String storeId);
  
  /// Obtiene estadísticas de productos de una tienda
  /// [storeId] - ID de la tienda
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getProductStats(
    String storeId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Obtiene los productos más vendidos de una tienda
  /// [storeId] - ID de la tienda
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [limit] - Número máximo de resultados
  Future<List<Map<String, dynamic>>> getTopSellingProducts(
    String storeId,
    DateTime startDate,
    DateTime endDate, {
    int limit = 10,
  });
  
  /// Obtiene el historial de precios de un producto
  /// [productId] - ID del producto
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<List<Map<String, dynamic>>> getProductPriceHistory(
    String productId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Obtiene el historial de stock de un producto
  /// [productId] - ID del producto
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<List<Map<String, dynamic>>> getProductStockHistory(
    String productId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Actualiza el contador de vistas de un producto
  /// [productId] - ID del producto
  Future<void> incrementProductViews(String productId);
  
  /// Obtiene el conteo total de productos
  Future<int> getTotalProductsCount();
  
  /// Obtiene el conteo de productos activos
  Future<int> getActiveProductsCount();
  
  /// Obtiene el conteo de productos de una tienda
  /// [storeId] - ID de la tienda
  Future<int> getStoreProductsCount(String storeId);
  
  /// Obtiene el conteo de productos en stock de una tienda
  /// [storeId] - ID de la tienda
  Future<int> getStoreInStockProductsCount(String storeId);
  
  /// Verifica la disponibilidad de un producto
  /// [productId] - ID del producto
  /// [quantity] - Cantidad requerida
  Future<bool> isProductAvailable(String productId, int quantity);
  
  /// Reserva stock de un producto temporalmente
  /// [productId] - ID del producto
  /// [quantity] - Cantidad a reservar
  /// [userId] - ID del usuario que reserva
  /// [expirationMinutes] - Minutos hasta que expire la reserva
  Future<String> reserveProductStock(
    String productId,
    int quantity,
    String userId,
    int expirationMinutes,
  );
  
  /// Libera una reserva de stock
  /// [reservationId] - ID de la reserva
  Future<void> releaseStockReservation(String reservationId);
  
  /// Confirma una reserva de stock (convierte en venta)
  /// [reservationId] - ID de la reserva
  Future<void> confirmStockReservation(String reservationId);
  
  /// Obtiene las reservas activas de un producto
  /// [productId] - ID del producto
  Future<List<Map<String, dynamic>>> getProductReservations(String productId);
  
  /// Limpia reservas expiradas
  Future<void> cleanExpiredReservations();
}

/// Repositorio abstracto para la gestión de categorías de productos
abstract class ProductCategoryRepository {
  /// Obtiene todas las categorías
  Future<List<ProductCategory>> getAllCategories();
  
  /// Obtiene una categoría por su ID
  Future<ProductCategory> getCategoryById(String categoryId);
  
  /// Obtiene categorías por tienda
  /// [storeId] - ID de la tienda
  Future<List<ProductCategory>> getCategoriesByStore(String storeId);
  
  /// Busca categorías por nombre
  /// [query] - Término de búsqueda
  Future<List<ProductCategory>> searchCategories(String query);
  
  /// Crea una nueva categoría
  /// [category] - Datos de la categoría a crear
  Future<ProductCategory> createCategory(ProductCategory category);
  
  /// Actualiza una categoría existente
  /// [categoryId] - ID de la categoría a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<ProductCategory> updateCategory(
    String categoryId,
    Map<String, dynamic> updates,
  );
  
  /// Actualiza el estado activo de una categoría
  /// [categoryId] - ID de la categoría
  /// [isActive] - Nuevo estado activo
  Future<ProductCategory> updateCategoryActiveStatus(
    String categoryId,
    bool isActive,
  );
  
  /// Elimina una categoría
  /// [categoryId] - ID de la categoría a eliminar
  Future<void> deleteCategory(String categoryId);
  
  /// Obtiene el conteo de productos por categoría
  /// [categoryId] - ID de la categoría
  /// [storeId] - ID de la tienda (opcional)
  Future<int> getProductCountByCategory(
    String categoryId, {
    String? storeId,
  });
  
  /// Obtiene categorías populares (con más productos)
  /// [storeId] - ID de la tienda (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<ProductCategory>> getPopularCategories({
    String? storeId,
    int limit = 10,
  });
  
  /// Obtiene el conteo total de categorías
  Future<int> getTotalCategoriesCount();
  
  /// Obtiene el conteo de categorías activas
  Future<int> getActiveCategoriesCount();
}