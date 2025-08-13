import 'package:equatable/equatable.dart';

/// Enumeración para los roles de usuario en Colmax
enum UserRole {
  cliente,
  dueno,
  repartidor;

  /// Convierte el enum a string para la base de datos
  String toJson() => name;

  /// Crea el enum desde string de la base de datos
  static UserRole fromJson(String json) {
    return UserRole.values.firstWhere(
      (role) => role.name == json,
      orElse: () => UserRole.cliente,
    );
  }

  /// Obtiene el nombre legible del rol
  String get displayName {
    switch (this) {
      case UserRole.cliente:
        return 'Cliente';
      case UserRole.dueno:
        return 'Dueño de Colmado';
      case UserRole.repartidor:
        return 'Repartidor';
    }
  }
}

/// Entidad que representa un usuario en el sistema Colmax
class User extends Equatable {
  /// ID único del usuario (UUID)
  final String id;
  
  /// Email del usuario
  final String email;
  
  /// Nombre completo del usuario
  final String fullName;
  
  /// Número de teléfono (opcional)
  final String? phone;
  
  /// Rol del usuario en el sistema
  final UserRole role;
  
  /// URL del avatar del usuario (opcional)
  final String? avatarUrl;
  
  /// Indica si el usuario está activo
  final bool isActive;
  
  /// Fecha de creación de la cuenta
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    required this.role,
    this.avatarUrl,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Crea una copia del usuario con campos actualizados
  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    UserRole? role,
    String? avatarUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convierte la entidad a Map para serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'role': role.toJson(),
      'avatar_url': avatarUrl,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una entidad desde Map (deserialización)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String?,
      role: UserRole.fromJson(json['role'] as String),
      avatarUrl: json['avatar_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Obtiene las iniciales del usuario para mostrar en avatares
  String get initials {
    final names = fullName.trim().split(' ');
    if (names.length >= 2) {
      return '${names.first[0]}${names.last[0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names.first[0].toUpperCase();
    }
    return 'U';
  }

  /// Verifica si el usuario es un cliente
  bool get isCustomer => role == UserRole.cliente;

  /// Verifica si el usuario es un dueño de colmado
  bool get isStoreOwner => role == UserRole.dueno;

  /// Verifica si el usuario es un repartidor
  bool get isDeliveryPerson => role == UserRole.repartidor;

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        phone,
        role,
        avatarUrl,
        isActive,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'User(id: $id, email: $email, fullName: $fullName, role: $role)';
  }
}