import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository _userRepository;

  GetCurrentUserUseCase(this._userRepository);

  Future<User?> execute() async {
    try {
      return await _userRepository.getCurrentUser();
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }
}

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

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

class SearchUsersUseCase {
  final UserRepository _userRepository;

  SearchUsersUseCase(this._userRepository);

  Future<List<User>> execute(String query, {int limit = 20}) async {
    try {
      if (query.isEmpty) {
        throw Exception('Search query is required');
      }
      return await _userRepository.searchUsers(query, limit: limit);
    } catch (e) {
      throw Exception('Search failed: ${e.toString()}');
    }
  }
}

class ValidateEmailUseCase {
  final UserRepository _userRepository;

  ValidateEmailUseCase(this._userRepository);

  Future<bool> execute(String email) async {
    try {
      if (email.isEmpty) {
        return false;
      }

      if (!_isValidEmail(email)) {
        return false;
      }

      return !(await _userRepository.isEmailRegistered(email));
    } catch (e) {
      throw Exception('Email validation failed: ${e.toString()}');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

class ValidatePhoneUseCase {
  final UserRepository _userRepository;

  ValidatePhoneUseCase(this._userRepository);

  Future<bool> execute(String phone) async {
    try {
      if (phone.isEmpty) {
        return false;
      }

      if (!_isValidPhone(phone)) {
        return false;
      }

      return !(await _userRepository.isPhoneRegistered(phone));
    } catch (e) {
      throw Exception('Phone validation failed: ${e.toString()}');
    }
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^[\+]?[1-9][\d]{1,14}$').hasMatch(phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
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
      if (updates.containsKey('fullName')) {
        final fullName = updates['fullName'] as String?;
        if (fullName == null || fullName.trim().isEmpty) {
          throw Exception('Full name is required');
        }
        if (fullName.trim().length < 2) {
          throw Exception('Full name must be at least 2 characters long');
        }
      }

      if (updates.containsKey('email')) {
        final email = updates['email'] as String?;
        if (email != null && email.isNotEmpty && !_isValidEmail(email)) {
          throw Exception('Invalid email format');
        }
      }

      if (updates.containsKey('phone')) {
        final phone = updates['phone'] as String?;
        if (phone != null && phone.isNotEmpty && !_isValidPhone(phone)) {
          throw Exception('Invalid phone number format');
        }
      }

      return await _userRepository.updateUserProfile(userId, updates);
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^[\+]?[1-9][\d]{1,14}$').hasMatch(phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }
}

class UpdateUserLocationUseCase {
  final UserRepository _userRepository;

  UpdateUserLocationUseCase(this._userRepository);

  Future<User> execute(String userId, double latitude, double longitude, {String? address}) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude value');
      }

      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude value');
      }

      return await _userRepository.updateUserLocation(userId, latitude, longitude, address: address);
    } catch (e) {
      throw Exception('Location update failed: ${e.toString()}');
    }
  }
}

class UpdateUserRoleUseCase {
  final UserRepository _userRepository;

  UpdateUserRoleUseCase(this._userRepository);

  Future<User> execute(String userId, UserRole newRole) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      return await _userRepository.updateUserRole(userId, newRole);
    } catch (e) {
      throw Exception('Role update failed: ${e.toString()}');
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
      throw Exception('Status update failed: ${e.toString()}');
    }
  }
}

class UploadProfileImageUseCase {
  final UserRepository _userRepository;

  UploadProfileImageUseCase(this._userRepository);

  Future<String> execute(String userId, List<int> imageBytes, String fileName) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      if (imageBytes.isEmpty) {
        throw Exception('Image data is required');
      }

      if (fileName.isEmpty) {
        throw Exception('File name is required');
      }

      return await _userRepository.uploadProfileImage(userId, imageBytes, fileName);
    } catch (e) {
      throw Exception('Image upload failed: ${e.toString()}');
    }
  }
}

class GetUsersByRoleUseCase {
  final UserRepository _userRepository;

  GetUsersByRoleUseCase(this._userRepository);

  Future<List<User>> execute(UserRole role, {bool? isActive, int limit = 50, int offset = 0}) async {
    try {
      return await _userRepository.getUsersByRole(role, isActive: isActive, limit: limit, offset: offset);
    } catch (e) {
      throw Exception('Failed to get users by role: ${e.toString()}');
    }
  }
}

class GetAvailableDeliveryPersonsUseCase {
  final UserRepository _userRepository;

  GetAvailableDeliveryPersonsUseCase(this._userRepository);

  Future<List<User>> execute(double latitude, double longitude, double radiusKm) async {
    try {
      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude value');
      }

      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude value');
      }

      if (radiusKm <= 0) {
        throw Exception('Radius must be greater than 0');
      }

      return await _userRepository.getAvailableDeliveryPersons(latitude, longitude, radiusKm);
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