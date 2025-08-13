import '../entities/store.dart';
import '../entities/user.dart';

/// Repositorio abstracto para la gestión de colmados/tiendas
/// Define los contratos que debe implementar la capa de datos
abstract class StoreRepository {
  /// Obtiene todas las tiendas activas
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir para paginación
  Future<List<Store>> getAllStores({int limit = 50, int offset = 0});
  
  /// Obtiene una tienda por su ID
  /// Lanza excepción si la tienda no existe
  Future<Store> getStoreById(String storeId);
  
  /// Obtiene múltiples tiendas por sus IDs
  Future<List<Store>> getStoresByIds(List<String> storeIds);
  
  /// Obtiene tiendas cercanas a una ubicación
  /// [latitude] - Latitud de la ubicación de referencia
  /// [longitude] - Longitud de la ubicación de referencia
  /// [radiusKm] - Radio de búsqueda en kilómetros (por defecto 3km)
  /// [limit] - Número máximo de resultados
  Future<List<Store>> getNearbyStores(
    double latitude,
    double longitude, {
    double radiusKm = 3.0,
    int limit = 20,
  });
  
  /// Obtiene tiendas cercanas ordenadas por prioridad
  /// Las tiendas con suscripción premium aparecen primero
  /// [latitude] - Latitud de la ubicación de referencia
  /// [longitude] - Longitud de la ubicación de referencia
  /// [radiusKm] - Radio de búsqueda en kilómetros
  /// [limit] - Número máximo de resultados
  Future<List<Store>> getNearbyStoresPrioritized(
    double latitude,
    double longitude, {
    double radiusKm = 3.0,
    int limit = 20,
  });
  
  /// Busca tiendas por nombre o descripción
  /// [query] - Término de búsqueda
  /// [latitude] - Latitud para ordenar por distancia (opcional)
  /// [longitude] - Longitud para ordenar por distancia (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Store>> searchStores(
    String query, {
    double? latitude,
    double? longitude,
    int limit = 20,
  });
  
  /// Obtiene tiendas por propietario
  /// [ownerId] - ID del propietario
  Future<List<Store>> getStoresByOwner(String ownerId);
  
  /// Crea una nueva tienda
  /// [store] - Datos de la tienda a crear
  Future<Store> createStore(Store store);
  
  /// Actualiza una tienda existente
  /// [storeId] - ID de la tienda a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<Store> updateStore(String storeId, Map<String, dynamic> updates);
  
  /// Actualiza la ubicación de una tienda
  /// [storeId] - ID de la tienda
  /// [latitude] - Nueva latitud
  /// [longitude] - Nueva longitud
  /// [address] - Nueva dirección
  Future<Store> updateStoreLocation(
    String storeId,
    double latitude,
    double longitude,
    String address,
  );
  
  /// Actualiza el horario de una tienda
  /// [storeId] - ID de la tienda
  /// [schedule] - Nuevo horario
  Future<Store> updateStoreSchedule(
    String storeId,
    Map<String, Map<String, String>> schedule,
  );
  
  /// Actualiza el estado activo de una tienda
  /// [storeId] - ID de la tienda
  /// [isActive] - Nuevo estado activo
  Future<Store> updateStoreActiveStatus(String storeId, bool isActive);
  
  /// Actualiza el estado de verificación de una tienda
  /// [storeId] - ID de la tienda
  /// [isVerified] - Nuevo estado de verificación
  /// [verifiedBy] - ID del administrador que verifica
  Future<Store> updateStoreVerificationStatus(
    String storeId,
    bool isVerified,
    String? verifiedBy,
  );
  
  /// Actualiza la imagen de perfil de una tienda
  /// [storeId] - ID de la tienda
  /// [imageUrl] - URL de la nueva imagen
  Future<Store> updateStoreImage(String storeId, String imageUrl);
  
  /// Sube una imagen para una tienda
  /// [storeId] - ID de la tienda
  /// [imageBytes] - Bytes de la imagen
  /// [fileName] - Nombre del archivo
  /// [imageType] - Tipo de imagen ('profile', 'cover', 'gallery')
  /// Retorna la URL de la imagen subida
  Future<String> uploadStoreImage(
    String storeId,
    List<int> imageBytes,
    String fileName,
    String imageType,
  );
  
  /// Elimina una imagen de una tienda
  /// [storeId] - ID de la tienda
  /// [imageUrl] - URL de la imagen a eliminar
  Future<void> deleteStoreImage(String storeId, String imageUrl);
  
  /// Agrega una imagen a la galería de una tienda
  /// [storeId] - ID de la tienda
  /// [imageUrl] - URL de la imagen
  Future<Store> addStoreGalleryImage(String storeId, String imageUrl);
  
  /// Remueve una imagen de la galería de una tienda
  /// [storeId] - ID de la tienda
  /// [imageUrl] - URL de la imagen a remover
  Future<Store> removeStoreGalleryImage(String storeId, String imageUrl);
  
  /// Actualiza la calificación promedio de una tienda
  /// [storeId] - ID de la tienda
  /// [newRating] - Nueva calificación
  /// [reviewCount] - Nuevo conteo de reseñas
  Future<Store> updateStoreRating(
    String storeId,
    double newRating,
    int reviewCount,
  );
  
  /// Obtiene tiendas por categoría
  /// [category] - Categoría a filtrar
  /// [latitude] - Latitud para ordenar por distancia (opcional)
  /// [longitude] - Longitud para ordenar por distancia (opcional)
  /// [limit] - Número máximo de resultados
  Future<List<Store>> getStoresByCategory(
    String category, {
    double? latitude,
    double? longitude,
    int limit = 20,
  });
  
  /// Obtiene tiendas abiertas actualmente
  /// [latitude] - Latitud de la ubicación de referencia
  /// [longitude] - Longitud de la ubicación de referencia
  /// [radiusKm] - Radio de búsqueda en kilómetros
  Future<List<Store>> getOpenStores(
    double latitude,
    double longitude, {
    double radiusKm = 3.0,
  });
  
  /// Obtiene tiendas con delivery disponible
  /// [latitude] - Latitud de la ubicación de referencia
  /// [longitude] - Longitud de la ubicación de referencia
  /// [radiusKm] - Radio de búsqueda en kilómetros
  Future<List<Store>> getStoresWithDelivery(
    double latitude,
    double longitude, {
    double radiusKm = 3.0,
  });
  
  /// Obtiene tiendas populares (mejor calificadas)
  /// [latitude] - Latitud de la ubicación de referencia (opcional)
  /// [longitude] - Longitud de la ubicación de referencia (opcional)
  /// [radiusKm] - Radio de búsqueda en kilómetros
  /// [limit] - Número máximo de resultados
  Future<List<Store>> getPopularStores({
    double? latitude,
    double? longitude,
    double radiusKm = 10.0,
    int limit = 10,
  });
  
  /// Obtiene tiendas con promociones activas
  /// [latitude] - Latitud de la ubicación de referencia (opcional)
  /// [longitude] - Longitud de la ubicación de referencia (opcional)
  /// [radiusKm] - Radio de búsqueda en kilómetros
  Future<List<Store>> getStoresWithPromotions({
    double? latitude,
    double? longitude,
    double radiusKm = 5.0,
  });
  
  /// Obtiene estadísticas de una tienda
  /// [storeId] - ID de la tienda
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<Map<String, dynamic>> getStoreStats(
    String storeId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Obtiene estadísticas generales de tiendas
  Future<Map<String, dynamic>> getGeneralStoreStats();
  
  /// Elimina una tienda (soft delete)
  /// [storeId] - ID de la tienda a eliminar
  Future<void> deleteStore(String storeId);
  
  /// Restaura una tienda eliminada
  /// [storeId] - ID de la tienda a restaurar
  Future<Store> restoreStore(String storeId);
  
  /// Obtiene tiendas que requieren verificación
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<Store>> getStoresPendingVerification({
    int limit = 20,
    int offset = 0,
  });
  
  /// Obtiene tiendas inactivas por un período específico
  /// [days] - Número de días de inactividad
  Future<List<Store>> getInactiveStores(int days);
  
  /// Actualiza la última actividad de una tienda
  /// [storeId] - ID de la tienda
  Future<void> updateStoreLastActivity(String storeId);
  
  /// Obtiene el conteo total de tiendas
  Future<int> getTotalStoresCount();
  
  /// Obtiene el conteo de tiendas activas
  Future<int> getActiveStoresCount();
  
  /// Obtiene el conteo de nuevas tiendas en un período
  /// [startDate] - Fecha de inicio
  /// [endDate] - Fecha de fin
  Future<int> getNewStoresCount(DateTime startDate, DateTime endDate);
  
  /// Obtiene tiendas favoritas de un usuario
  /// [userId] - ID del usuario
  Future<List<Store>> getUserFavoriteStores(String userId);
  
  /// Agrega una tienda a favoritos
  /// [userId] - ID del usuario
  /// [storeId] - ID de la tienda
  Future<void> addStoreToFavorites(String userId, String storeId);
  
  /// Remueve una tienda de favoritos
  /// [userId] - ID del usuario
  /// [storeId] - ID de la tienda
  Future<void> removeStoreFromFavorites(String userId, String storeId);
  
  /// Verifica si una tienda está en favoritos
  /// [userId] - ID del usuario
  /// [storeId] - ID de la tienda
  Future<bool> isStoreInFavorites(String userId, String storeId);
  
  /// Obtiene el tiempo estimado de entrega para una tienda
  /// [storeId] - ID de la tienda
  /// [latitude] - Latitud de destino
  /// [longitude] - Longitud de destino
  Future<int> getEstimatedDeliveryTime(
    String storeId,
    double latitude,
    double longitude,
  );
  
  /// Obtiene el costo de delivery para una tienda
  /// [storeId] - ID de la tienda
  /// [latitude] - Latitud de destino
  /// [longitude] - Longitud de destino
  Future<double> getDeliveryCost(
    String storeId,
    double latitude,
    double longitude,
  );
  
  /// Verifica si una tienda hace delivery a una ubicación
  /// [storeId] - ID de la tienda
  /// [latitude] - Latitud de destino
  /// [longitude] - Longitud de destino
  Future<bool> doesStoreDeliverTo(
    String storeId,
    double latitude,
    double longitude,
  );
}