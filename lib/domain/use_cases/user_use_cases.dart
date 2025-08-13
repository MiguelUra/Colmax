import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserByIdUseCase {
  final UserRepository _userRepository;

  GetUserByIdUseCase(this._userRepository);

  Future<User> execute(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }
      return await _userRepository.getUserById(userId);
    } catch (e) {
      throw Exception('Failed to get user: ${e.toString()}');
    }
  }
}

class IsEmailRegisteredUseCase {
  final UserRepository _userRepository;

  IsEmailRegisteredUseCase(this._userRepository);

  Future<bool> execute(String email) async {
    try {
      if (email.trim().isEmpty) {
        throw Exception('Email is required');
      }
      if (!_isValidEmail(email.trim())) {
        throw Exception('Invalid email format');
      }
      return await _userRepository.isEmailRegistered(email.trim());
    } catch (e) {
      throw Exception('Failed to check email registration: ${e.toString()}');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

class IsPhoneRegisteredUseCase {
  final UserRepository _userRepository;

  IsPhoneRegisteredUseCase(this._userRepository);

  Future<bool> execute(String phone) async {
    try {
      if (phone.trim().isEmpty) {
        throw Exception('Phone is required');
      }
      return await _userRepository.isPhoneRegistered(phone.trim());
    } catch (e) {
      throw Exception('Failed to check phone registration: ${e.toString()}');
    }
  }
}

class UpdateUserProfileUseCase {
  final UserRepository _userRepository;

  UpdateUserProfileUseCase(this._userRepository);

  Future<User> execute(String userId, Map<String, dynamic> updates) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      // Validate updates
      if (updates.containsKey('email')) {
        final email = updates['email'] as String;
        if (email.trim().isEmpty) {
          throw Exception('Email cannot be empty');
        }
        if (!_isValidEmail(email.trim())) {
          throw Exception('Invalid email format');
        }
      }
      if (updates.containsKey('fullName') && (updates['fullName'] as String).trim().isEmpty) {
        throw Exception('Full name cannot be empty');
      }
      if (updates.containsKey('phone') && (updates['phone'] as String?)?.trim().isEmpty == true) {
        throw Exception('Phone cannot be empty if provided');
      }

      return await _userRepository.updateUserProfile(userId, updates);
    } catch (e) {
      throw Exception('Failed to update user profile: ${e.toString()}');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

class UpdateUserLocationUseCase {
  final UserRepository _userRepository;

  UpdateUserLocationUseCase(this._userRepository);

  Future<User> execute(
    String userId,
    double latitude,
    double longitude, {
    String? address,
  }) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }
      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude');
      }
      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude');
      }

      return await _userRepository.updateUserLocation(
        userId,
        latitude,
        longitude,
        address: address,
      );
    } catch (e) {
      throw Exception('Failed to update user location: ${e.toString()}');
    }
  }
}

class UpdateUserActiveStatusUseCase {
  final UserRepository _userRepository;

  UpdateUserActiveStatusUseCase(this._userRepository);

  Future<User> execute(String userId, bool isActive) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }
      return await _userRepository.updateUserActiveStatus(userId, isActive);
    } catch (e) {
      throw Exception('Failed to update user status: ${e.toString()}');
    }
  }
}

class UpdateUserRoleUseCase {
  final UserRepository _userRepository;

  UpdateUserRoleUseCase(this._userRepository);

  Future<User> execute(String userId, UserRole role) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }
      return await _userRepository.updateUserRole(userId, role);
    } catch (e) {
      throw Exception('Failed to update user role: ${e.toString()}');
    }
  }
}

class GetUsersByRoleUseCase {
  final UserRepository _userRepository;

  GetUsersByRoleUseCase(this._userRepository);

  Future<List<User>> execute(UserRole role, {int limit = 50, int offset = 0}) async {
    try {
      return await _userRepository.getUsersByRole(role, limit: limit, offset: offset);
    } catch (e) {
      throw Exception('Failed to get users by role: ${e.toString()}');
    }
  }
}

class SearchUsersUseCase {
  final UserRepository _userRepository;

  SearchUsersUseCase(this._userRepository);

  Future<List<User>> execute(String query, {int limit = 20}) async {
    try {
      if (query.trim().isEmpty) {
        throw Exception('Search query is required');
      }
      return await _userRepository.searchUsers(query.trim(), limit: limit);
    } catch (e) {
      throw Exception('Failed to search users: ${e.toString()}');
    }
  }
}

class GetDeliveryPersonsByRoleUseCase {
  final UserRepository _userRepository;

  GetDeliveryPersonsByRoleUseCase(this._userRepository);

  Future<List<User>> execute({bool? isActive, int limit = 50, int offset = 0}) async {
    try {
      return await _userRepository.getUsersByRole(
        UserRole.repartidor,
        isActive: isActive,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      throw Exception('Failed to get delivery persons: ${e.toString()}');
    }
  }
}

class GetAvailableDeliveryPersonsUseCase {
  final UserRepository _userRepository;

  GetAvailableDeliveryPersonsUseCase(this._userRepository);

  Future<List<User>> execute(
    double latitude,
    double longitude,
    double radiusKm,
  ) async {
    try {
      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude');
      }
      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude');
      }
      if (radiusKm <= 0) {
        throw Exception('Radius must be positive');
      }
      return await _userRepository.getAvailableDeliveryPersons(
        latitude,
        longitude,
        radiusKm,
      );
    } catch (e) {
      throw Exception('Failed to get available delivery persons: ${e.toString()}');
    }
  }
}

class GetUserStatsUseCase {
  final UserRepository _userRepository;

  GetUserStatsUseCase(this._userRepository);

  Future<Map<String, dynamic>> execute() async {
    try {
      return await _userRepository.getUserStats();
    } catch (e) {
      throw Exception('Failed to get user stats: ${e.toString()}');
    }
  }
}

class DeleteUserUseCase {
  final UserRepository _userRepository;

  DeleteUserUseCase(this._userRepository);

  Future<void> execute(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }
      await _userRepository.deleteUser(userId);
    } catch (e) {
      throw Exception('Failed to delete user: ${e.toString()}');
    }
  }
}