import '../entities/store.dart';
import '../entities/user.dart';
import '../repositories/store_repository.dart';
import '../repositories/user_repository.dart';

class GetStoreByIdUseCase {
  final StoreRepository _storeRepository;

  GetStoreByIdUseCase(this._storeRepository);

  Future<Store> execute(String storeId) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      return await _storeRepository.getStoreById(storeId);
    } catch (e) {
      throw Exception('Failed to get store: ${e.toString()}');
    }
  }
}

class GetNearbyStoresUseCase {
  final StoreRepository _storeRepository;

  GetNearbyStoresUseCase(this._storeRepository);

  Future<List<Store>> execute(
    double latitude,
    double longitude, {
    double radiusKm = 3.0,
    int limit = 20,
    bool prioritized = false,
  }) async {
    try {
      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude');
      }
      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude');
      }

      if (prioritized) {
        return await _storeRepository.getNearbyStoresPrioritized(
          latitude,
          longitude,
          radiusKm: radiusKm,
          limit: limit,
        );
      } else {
        return await _storeRepository.getNearbyStores(
          latitude,
          longitude,
          radiusKm: radiusKm,
          limit: limit,
        );
      }
    } catch (e) {
      throw Exception('Failed to get nearby stores: ${e.toString()}');
    }
  }
}

class SearchStoresUseCase {
  final StoreRepository _storeRepository;

  SearchStoresUseCase(this._storeRepository);

  Future<List<Store>> execute(
    String query, {
    double? latitude,
    double? longitude,
    int limit = 20,
  }) async {
    try {
      if (query.trim().isEmpty) {
        throw Exception('Search query is required');
      }
      return await _storeRepository.searchStores(
        query.trim(),
        latitude: latitude,
        longitude: longitude,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Failed to search stores: ${e.toString()}');
    }
  }
}

class GetStoresByOwnerUseCase {
  final StoreRepository _storeRepository;

  GetStoresByOwnerUseCase(this._storeRepository);

  Future<List<Store>> execute(String ownerId) async {
    try {
      if (ownerId.isEmpty) {
        throw Exception('Owner ID is required');
      }
      return await _storeRepository.getStoresByOwner(ownerId);
    } catch (e) {
      throw Exception('Failed to get stores by owner: ${e.toString()}');
    }
  }
}

class CreateStoreUseCase {
  final StoreRepository _storeRepository;
  final UserRepository _userRepository;

  CreateStoreUseCase(this._storeRepository, this._userRepository);

  Future<Store> execute(Store store) async {
    try {
      // Validate owner exists and has correct role
      final owner = await _userRepository.getUserById(store.ownerId);
      if (owner.role != UserRole.dueno) {
        throw Exception('User must be a store owner to create a store');
      }
      if (!owner.isActive) {
        throw Exception('Owner account is not active');
      }

      // Validate store data
      if (store.name.trim().isEmpty) {
        throw Exception('Store name is required');
      }
      if (store.address.trim().isEmpty) {
        throw Exception('Store address is required');
      }
      if (store.phone?.trim().isEmpty == true) {
        throw Exception('Store phone cannot be empty if provided');
      }
      if (store.location != null) {
        if (store.location!.latitude < -90 || store.location!.latitude > 90) {
          throw Exception('Invalid latitude');
        }
        if (store.location!.longitude < -180 || store.location!.longitude > 180) {
          throw Exception('Invalid longitude');
        }
      }

      return await _storeRepository.createStore(store);
    } catch (e) {
      throw Exception('Failed to create store: ${e.toString()}');
    }
  }
}

class UpdateStoreUseCase {
  final StoreRepository _storeRepository;

  UpdateStoreUseCase(this._storeRepository);

  Future<Store> execute(String storeId, Map<String, dynamic> updates) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }

      // Validate updates
      if (updates.containsKey('name') && (updates['name'] as String).trim().isEmpty) {
        throw Exception('Store name cannot be empty');
      }
      if (updates.containsKey('address') && (updates['address'] as String).trim().isEmpty) {
        throw Exception('Store address cannot be empty');
      }
      if (updates.containsKey('phone') && (updates['phone'] as String).trim().isEmpty) {
        throw Exception('Store phone cannot be empty');
      }
      if (updates.containsKey('latitude')) {
        final lat = updates['latitude'] as double;
        if (lat < -90 || lat > 90) {
          throw Exception('Invalid latitude');
        }
      }
      if (updates.containsKey('longitude')) {
        final lng = updates['longitude'] as double;
        if (lng < -180 || lng > 180) {
          throw Exception('Invalid longitude');
        }
      }

      return await _storeRepository.updateStore(storeId, updates);
    } catch (e) {
      throw Exception('Failed to update store: ${e.toString()}');
    }
  }
}

class UpdateStoreLocationUseCase {
  final StoreRepository _storeRepository;

  UpdateStoreLocationUseCase(this._storeRepository);

  Future<Store> execute(
    String storeId,
    double latitude,
    double longitude,
    String address,
  ) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      if (address.trim().isEmpty) {
        throw Exception('Address is required');
      }
      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude');
      }
      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude');
      }

      return await _storeRepository.updateStoreLocation(
        storeId,
        latitude,
        longitude,
        address.trim(),
      );
    } catch (e) {
      throw Exception('Failed to update store location: ${e.toString()}');
    }
  }
}

class UpdateStoreActiveStatusUseCase {
  final StoreRepository _storeRepository;

  UpdateStoreActiveStatusUseCase(this._storeRepository);

  Future<Store> execute(String storeId, bool isActive) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      return await _storeRepository.updateStoreActiveStatus(storeId, isActive);
    } catch (e) {
      throw Exception('Failed to update store status: ${e.toString()}');
    }
  }
}

class VerifyStoreUseCase {
  final StoreRepository _storeRepository;

  VerifyStoreUseCase(this._storeRepository);

  Future<Store> execute(String storeId, bool isVerified, String verifiedBy) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      if (verifiedBy.isEmpty) {
        throw Exception('Verified by user ID is required');
      }
      return await _storeRepository.updateStoreVerificationStatus(
        storeId,
        isVerified,
        verifiedBy,
      );
    } catch (e) {
      throw Exception('Failed to verify store: ${e.toString()}');
    }
  }
}

class GetDeliveryCostUseCase {
  final StoreRepository _storeRepository;

  GetDeliveryCostUseCase(this._storeRepository);

  Future<double> execute(
    String storeId,
    double latitude,
    double longitude,
  ) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude');
      }
      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude');
      }

      return await _storeRepository.getDeliveryCost(
        storeId,
        latitude,
        longitude,
      );
    } catch (e) {
      throw Exception('Failed to get delivery cost: ${e.toString()}');
    }
  }
}

class GetEstimatedDeliveryTimeUseCase {
  final StoreRepository _storeRepository;

  GetEstimatedDeliveryTimeUseCase(this._storeRepository);

  Future<int> execute(
    String storeId,
    double latitude,
    double longitude,
  ) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude');
      }
      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude');
      }

      return await _storeRepository.getEstimatedDeliveryTime(
        storeId,
        latitude,
        longitude,
      );
    } catch (e) {
      throw Exception('Failed to get estimated delivery time: ${e.toString()}');
    }
  }
}

class CheckStoreDeliveryUseCase {
  final StoreRepository _storeRepository;

  CheckStoreDeliveryUseCase(this._storeRepository);

  Future<bool> execute(
    String storeId,
    double latitude,
    double longitude,
  ) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      if (latitude < -90 || latitude > 90) {
        throw Exception('Invalid latitude');
      }
      if (longitude < -180 || longitude > 180) {
        throw Exception('Invalid longitude');
      }

      return await _storeRepository.doesStoreDeliverTo(
        storeId,
        latitude,
        longitude,
      );
    } catch (e) {
      throw Exception('Failed to check store delivery: ${e.toString()}');
    }
  }
}

class GetAllStoresUseCase {
  final StoreRepository _storeRepository;

  GetAllStoresUseCase(this._storeRepository);

  Future<List<Store>> execute({int limit = 50, int offset = 0}) async {
    try {
      return await _storeRepository.getAllStores(limit: limit, offset: offset);
    } catch (e) {
      throw Exception('Failed to get all stores: ${e.toString()}');
    }
  }
}