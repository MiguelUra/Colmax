import '../entities/promotion.dart';

/// Repositorio abstracto para la gestión de promociones
/// Define los contratos que debe implementar la capa de datos
abstract class PromotionRepository {
  /// Obtiene todas las promociones
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir para paginación
  Future<List<Promotion>> getAllPromotions({int limit = 50, int offset = 0});
  
  /// Obtiene una promoción por su ID
  /// Lanza excepción si la promoción no existe
  Future<Promotion> getPromotionById(String promotionId);
  
  /// Obtiene múltiples promociones por sus IDs
  Future<List<Promotion>> getPromotionsByIds(List<String> promotionIds);
  
  /// Obtiene promociones de una tienda específica
  /// [storeId] - ID de la tienda
  /// [status] - Filtrar por estado (opcional)
  /// [type] - Filtrar por tipo (opcional)
  /// [isActive] - Filtrar por promociones activas (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Promotion>> getPromotionsByStore(
    String storeId, {
    PromotionStatus? status,
    PromotionType? type,
    bool? isActive,
    int limit = 20,
    int offset = 0,
  });
  
  /// Obtiene promociones activas
  /// [storeId] - ID de la tienda (opcional)
  /// [type] - Filtrar por tipo (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Promotion>> getActivePromotions({
    String? storeId,
    PromotionType? type,
    int limit = 20,
  });
  
  /// Obtiene promociones por estado
  /// [status] - Estado a filtrar
  /// [storeId] - ID de la tienda (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Promotion>> getPromotionsByStatus(
    PromotionStatus status, {
    String? storeId,
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene promociones por tipo
  /// [type] - Tipo a filtrar
  /// [storeId] - ID de la tienda (opcional)
  /// [isActive] - Filtrar por promociones activas (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Promotion>> getPromotionsByType(
    PromotionType type, {
    String? storeId,
    bool? isActive,
    int limit = 20,
  });
  
  /// Busca promociones por nombre o descripción
  /// [query] - Término de búsqueda
  /// [storeId] - ID de la tienda (opcional)
  /// [isActive] - Filtrar por promociones activas
  /// [limit] - Número máximo de resultados
  Future<List<Promotion>> searchPromotions(
    String query, {
    String? storeId,
    bool isActive = true,
    int limit = 20,
  });
  
  /// Obtiene promociones por código promocional
  /// [promoCode] - Código promocional
  /// [storeId] - ID de la tienda (opcional)
  Future<Promotion?> getPromotionByCode(
    String promoCode, {
    String? storeId,
  });
  
  /// Obtiene promociones aplicables a un producto
  /// [productId] - ID del producto
  /// [storeId] - ID de la tienda
  /// [isActive] - Solo promociones activas
  Future<List<Promotion>> getPromotionsForProduct(
    String productId,
    String storeId, {
    bool isActive = true,
  });
  
  /// Obtiene promociones aplicables a una categoría
  /// [categoryId] - ID de la categoría
  /// [storeId] - ID de la tienda (opcional)
  /// [isActive] - Solo promociones activas
  Future<List<Promotion>> getPromotionsForCategory(
    String categoryId, {
    String? storeId,
    bool isActive = true,
  });
  
  /// Obtiene promociones que expiran pronto
  /// [daysAhead] - Número de días hacia adelante para buscar
  /// [storeId] - ID de la tienda (opcional)
  Future<List<Promotion>> getExpiringPromotions(
    int daysAhead, {
    String? storeId,
  });
  
  /// Obtiene promociones populares (más utilizadas)
  /// [storeId] - ID de la tienda (opcional)
  /// [limit] - Número máximo de resultados
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  Future<List<Promotion>> getPopularPromotions({
    String? storeId,
    int limit = 10,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Crea una nueva promoción
  /// [promotion] - Datos de la promoción a crear
  Future<Promotion> createPromotion(Promotion promotion);
  
  /// Actualiza una promoción existente
  /// [promotionId] - ID de la promoción a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<Promotion> updatePromotion(
    String promotionId,
    Map<String, dynamic> updates,
  );
  
  /// Actualiza el estado de una promoción
  /// [promotionId] - ID de la promoción
  /// [newStatus] - Nuevo estado
  /// [updatedBy] - ID del usuario que actualiza
  Future<Promotion> updatePromotionStatus(
    String promotionId,
    PromotionStatus newStatus,
    String updatedBy,
  );
  
  /// Activa una promoción
  /// [promotionId] - ID de la promoción
  /// [activatedBy] - ID del usuario que activa
  Future<Promotion> activatePromotion(String promotionId, String activatedBy);
  
  /// Desactiva una promoción
  /// [promotionId] - ID de la promoción
  /// [deactivatedBy] - ID del usuario que desactiva
  /// [reason] - Razón de la desactivación (opcional)
  Future<Promotion> deactivatePromotion(
    String promotionId,
    String deactivatedBy, {
    String? reason,
  });
  
  /// Pausa una promoción
  /// [promotionId] - ID de la promoción
  /// [pausedBy] - ID del usuario que pausa
  Future<Promotion> pausePromotion(String promotionId, String pausedBy);
  
  /// Reanuda una promoción pausada
  /// [promotionId] - ID de la promoción
  /// [resumedBy] - ID del usuario que reanuda
  Future<Promotion> resumePromotion(String promotionId, String resumedBy);
  
  /// Actualiza las fechas de una promoción
  /// [promotionId] - ID de la promoción
  /// [startDate] - Nueva fecha de inicio
  /// [endDate] - Nueva fecha de fin
  Future<Promotion> updatePromotionDates(
    String promotionId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Actualiza el descuento de una promoción
  /// [promotionId] - ID de la promoción
  /// [discountValue] - Nuevo valor de descuento
  /// [maxDiscount] - Nuevo descuento máximo (opcional)
  Future<Promotion> updatePromotionDiscount(
    String promotionId,
    double discountValue, {
    double? maxDiscount,
  });
  
  /// Actualiza los límites de uso de una promoción
  /// [promotionId] - ID de la promoción
  /// [maxUses] - Nuevo máximo de usos totales (opcional)
  /// [maxUsesPerUser] - Nuevo máximo de usos por usuario (opcional)
  Future<Promotion> updatePromotionUsageLimits(
    String promotionId, {
    int? maxUses,
    int? maxUsesPerUser,
  });
  
  /// Actualiza los productos aplicables de una promoción
  /// [promotionId] - ID de la promoción
  /// [productIds] - Lista de IDs de productos
  Future<Promotion> updatePromotionProducts(
    String promotionId,
    List<String> productIds,
  );
  
  /// Actualiza las categorías aplicables de una promoción
  /// [promotionId] - ID de la promoción
  /// [categoryIds] - Lista de IDs de categorías
  Future<Promotion> updatePromotionCategories(
    String promotionId,
    List<String> categoryIds,
  );
  
  /// Actualiza la imagen de una promoción
  /// [promotionId] - ID de la promoción
  /// [imageUrl] - URL de la nueva imagen
  Future<Promotion> updatePromotionImage(String promotionId, String imageUrl);
  
  /// Sube una imagen para una promoción
  /// [promotionId] - ID de la promoción
  /// [imageBytes] - Bytes de la imagen
  /// [fileName] - Nombre del archivo
  /// Retorna la URL de la imagen subida
  Future<String> uploadPromotionImage(
    String promotionId,
    List<int> imageBytes,
    String fileName,
  );
  
  /// Elimina la imagen de una promoción
  /// [promotionId] - ID de la promoción
  Future<Promotion> removePromotionImage(String promotionId);
  
  /// Valida si una promoción es aplicable a un pedido
  /// [promotionId] - ID de la promoción
  /// [userId] - ID del usuario
  /// [storeId] - ID de la tienda
  /// [orderTotal] - Total del pedido
  /// [productIds] - IDs de productos en el pedido
  Future<Map<String, dynamic>> validatePromotionForOrder(
    String promotionId,
    String userId,
    String storeId,
    double orderTotal,
    List<String> productIds,
  );
  
  /// Calcula el descuento de una promoción para un pedido
  /// [promotionId] - ID de la promoción
  /// [orderTotal] - Total del pedido
  /// [productIds] - IDs de productos en el pedido
  Future<double> calculatePromotionDiscount(
    String promotionId,
    double orderTotal,
    List<String> productIds,
  );
  
  /// Aplica una promoción a un pedido
  /// [promotionId] - ID de la promoción
  /// [userId] - ID del usuario
  /// [orderId] - ID del pedido
  /// [discountAmount] - Monto del descuento aplicado
  Future<PromotionUsage> applyPromotionToOrder(
    String promotionId,
    String userId,
    String orderId,
    double discountAmount,
  );
  
  /// Obtiene el historial de uso de una promoción
  /// [promotionId] - ID de la promoción
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<PromotionUsage>> getPromotionUsageHistory(
    String promotionId, {
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene estadísticas de una promoción
  /// [promotionId] - ID de la promoción
  Future<Map<String, dynamic>> getPromotionStats(String promotionId);
  
  /// Obtiene estadísticas de promociones de una tienda
  /// [storeId] - ID de la tienda
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getStorePromotionStats(
    String storeId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Obtiene el conteo total de promociones
  Future<int> getTotalPromotionsCount();
  
  /// Obtiene el conteo de promociones activas
  /// [storeId] - ID de la tienda (opcional)
  Future<int> getActivePromotionsCount({String? storeId});
  
  /// Obtiene el conteo de promociones por estado
  /// [status] - Estado a contar
  /// [storeId] - ID de la tienda (opcional)
  Future<int> getPromotionsCountByStatus(
    PromotionStatus status, {
    String? storeId,
  });
  
  /// Procesa promociones que deben expirar
  /// Actualiza el estado de promociones vencidas
  Future<List<Promotion>> processExpiredPromotions();
  
  /// Procesa promociones que deben activarse
  /// Activa promociones cuya fecha de inicio ha llegado
  Future<List<Promotion>> processPromotionsToActivate();
  
  /// Elimina una promoción (soft delete)
  /// [promotionId] - ID de la promoción a eliminar
  Future<void> deletePromotion(String promotionId);
  
  /// Restaura una promoción eliminada
  /// [promotionId] - ID de la promoción a restaurar
  Future<Promotion> restorePromotion(String promotionId);
  
  /// Duplica una promoción
  /// [promotionId] - ID de la promoción a duplicar
  /// [newName] - Nuevo nombre para la promoción duplicada
  /// [newStartDate] - Nueva fecha de inicio
  /// [newEndDate] - Nueva fecha de fin
  Future<Promotion> duplicatePromotion(
    String promotionId,
    String newName,
    DateTime newStartDate,
    DateTime newEndDate,
  );
}

/// Repositorio abstracto para la gestión de uso de promociones
abstract class PromotionUsageRepository {
  /// Obtiene todos los usos de promociones
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<PromotionUsage>> getAllUsages({int limit = 50, int offset = 0});
  
  /// Obtiene un uso de promoción por su ID
  Future<PromotionUsage> getUsageById(String usageId);
  
  /// Obtiene usos de una promoción específica
  /// [promotionId] - ID de la promoción
  /// [userId] - ID del usuario (opcional)
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<PromotionUsage>> getUsagesByPromotion(
    String promotionId, {
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene usos de promociones de un usuario
  /// [userId] - ID del usuario
  /// [promotionId] - ID de la promoción (opcional)
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<PromotionUsage>> getUsagesByUser(
    String userId, {
    String? promotionId,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 20,
  });
  
  /// Obtiene el conteo de usos de una promoción
  /// [promotionId] - ID de la promoción
  /// [userId] - ID del usuario (opcional, para contar usos por usuario)
  Future<int> getPromotionUsageCount(
    String promotionId, {
    String? userId,
  });
  
  /// Obtiene el total de descuentos aplicados por una promoción
  /// [promotionId] - ID de la promoción
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  Future<double> getTotalDiscountByPromotion(
    String promotionId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Crea un nuevo uso de promoción
  /// [usage] - Datos del uso a crear
  Future<PromotionUsage> createUsage(PromotionUsage usage);
  
  /// Actualiza un uso de promoción
  /// [usageId] - ID del uso a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<PromotionUsage> updateUsage(
    String usageId,
    Map<String, dynamic> updates,
  );
  
  /// Elimina un uso de promoción
  /// [usageId] - ID del uso a eliminar
  Future<void> deleteUsage(String usageId);
  
  /// Obtiene estadísticas de uso de promociones
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [promotionId] - ID de la promoción (opcional)
  /// [userId] - ID del usuario (opcional)
  Future<Map<String, dynamic>> getUsageStats(
    DateTime startDate,
    DateTime endDate, {
    String? promotionId,
    String? userId,
  });
  
  /// Obtiene las promociones más utilizadas
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  /// [storeId] - ID de la tienda (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Map<String, dynamic>>> getMostUsedPromotions(
    DateTime startDate,
    DateTime endDate, {
    String? storeId,
    int limit = 10,
  });
  
  /// Obtiene el ahorro total de un usuario por promociones
  /// [userId] - ID del usuario
  /// [startDate] - Fecha de inicio del período (opcional)
  /// [endDate] - Fecha de fin del período (opcional)
  Future<double> getUserTotalSavings(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
  });
}