import '../entities/user.dart';

/// Repositorio abstracto para la gestión de usuarios
/// Define los contratos que debe implementar la capa de datos
abstract class UserRepository {
  /// Obtiene el usuario actual autenticado
  /// Retorna null si no hay usuario autenticado
  Future<User?> getCurrentUser();
  
  /// Obtiene un usuario por su ID
  /// Lanza excepción si el usuario no existe
  Future<User> getUserById(String userId);
  
  /// Obtiene múltiples usuarios por sus IDs
  Future<List<User>> getUsersByIds(List<String> userIds);
  
  /// Busca usuarios por nombre o email
  /// [query] - Término de búsqueda
  /// [limit] - Número máximo de resultados (por defecto 20)
  Future<List<User>> searchUsers(String query, {int limit = 20});
  
  /// Actualiza el perfil del usuario
  /// [userId] - ID del usuario a actualizar
  /// [updates] - Mapa con los campos a actualizar
  Future<User> updateUserProfile(String userId, Map<String, dynamic> updates);
  
  /// Actualiza la ubicación del usuario
  /// [userId] - ID del usuario
  /// [latitude] - Latitud de la nueva ubicación
  /// [longitude] - Longitud de la nueva ubicación
  /// [address] - Dirección legible (opcional)
  Future<User> updateUserLocation(
    String userId, 
    double latitude, 
    double longitude, 
    {String? address}
  );
  
  /// Actualiza el rol del usuario (solo para administradores)
  /// [userId] - ID del usuario
  /// [newRole] - Nuevo rol a asignar
  Future<User> updateUserRole(String userId, UserRole newRole);
  
  /// Actualiza el estado activo del usuario
  /// [userId] - ID del usuario
  /// [isActive] - Nuevo estado activo
  Future<User> updateUserActiveStatus(String userId, bool isActive);
  
  /// Actualiza la foto de perfil del usuario
  /// [userId] - ID del usuario
  /// [imageUrl] - URL de la nueva imagen de perfil
  Future<User> updateProfileImage(String userId, String imageUrl);
  
  /// Sube una imagen de perfil
  /// [userId] - ID del usuario
  /// [imageBytes] - Bytes de la imagen
  /// [fileName] - Nombre del archivo
  /// Retorna la URL de la imagen subida
  Future<String> uploadProfileImage(
    String userId, 
    List<int> imageBytes, 
    String fileName
  );
  
  /// Elimina la foto de perfil del usuario
  /// [userId] - ID del usuario
  Future<User> removeProfileImage(String userId);
  
  /// Obtiene usuarios por rol
  /// [role] - Rol a filtrar
  /// [isActive] - Filtrar por estado activo (opcional)
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir para paginación
  Future<List<User>> getUsersByRole(
    UserRole role, {
    bool? isActive,
    int limit = 50,
    int offset = 0,
  });
  
  /// Obtiene repartidores disponibles en un área específica
  /// [latitude] - Latitud del centro del área
  /// [longitude] - Longitud del centro del área
  /// [radiusKm] - Radio de búsqueda en kilómetros
  Future<List<User>> getAvailableDeliveryPersons(
    double latitude, 
    double longitude, 
    double radiusKm
  );
  
  /// Obtiene estadísticas de usuarios
  /// Retorna un mapa con conteos por rol y estado
  Future<Map<String, dynamic>> getUserStats();
  
  /// Verifica si un email ya está registrado
  /// [email] - Email a verificar
  Future<bool> isEmailRegistered(String email);
  
  /// Verifica si un teléfono ya está registrado
  /// [phone] - Teléfono a verificar
  Future<bool> isPhoneRegistered(String phone);
  
  /// Elimina un usuario (soft delete)
  /// [userId] - ID del usuario a eliminar
  Future<void> deleteUser(String userId);
  
  /// Restaura un usuario eliminado
  /// [userId] - ID del usuario a restaurar
  Future<User> restoreUser(String userId);
  
  /// Obtiene el historial de ubicaciones de un repartidor
  /// [deliveryPersonId] - ID del repartidor
  /// [startDate] - Fecha de inicio del período
  /// [endDate] - Fecha de fin del período
  Future<List<Map<String, dynamic>>> getDeliveryPersonLocationHistory(
    String deliveryPersonId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// Actualiza las preferencias de notificación del usuario
  /// [userId] - ID del usuario
  /// [preferences] - Nuevas preferencias
  Future<User> updateNotificationPreferences(
    String userId, 
    Map<String, bool> preferences
  );
  
  /// Obtiene usuarios que requieren verificación
  /// [limit] - Número máximo de resultados
  /// [offset] - Número de resultados a omitir
  Future<List<User>> getUsersPendingVerification({
    int limit = 20,
    int offset = 0,
  });
  
  /// Verifica un usuario
  /// [userId] - ID del usuario a verificar
  /// [verifiedBy] - ID del administrador que verifica
  Future<User> verifyUser(String userId, String verifiedBy);
  
  /// Obtiene usuarios inactivos por un período específico
  /// [days] - Número de días de inactividad
  Future<List<User>> getInactiveUsers(int days);
  
  /// Actualiza la última actividad del usuario
  /// [userId] - ID del usuario
  Future<void> updateLastActivity(String userId);
  
  /// Obtiene el conteo total de usuarios
  Future<int> getTotalUsersCount();
  
  /// Obtiene el conteo de usuarios activos
  Future<int> getActiveUsersCount();
  
  /// Obtiene el conteo de nuevos usuarios en un período
  /// [startDate] - Fecha de inicio
  /// [endDate] - Fecha de fin
  Future<int> getNewUsersCount(DateTime startDate, DateTime endDate);
}