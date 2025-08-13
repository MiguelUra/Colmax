import '../entities/delivery.dart';
import '../repositories/delivery_repository.dart';
import '../repositories/user_repository.dart';
import '../repositories/order_repository.dart';

class CreateDeliveryUseCase {
  final DeliveryRepository _deliveryRepository;
  final UserRepository _userRepository;
  final OrderRepository _orderRepository;

  CreateDeliveryUseCase(
    this._deliveryRepository,
    this._userRepository,
    this._orderRepository,
  );

  Future<Delivery> execute(Delivery delivery) async {
    try {
      // Validate delivery person exists and is active
      final deliveryPerson = await _userRepository.getUserById(delivery.deliveryPersonId);
      if (!deliveryPerson.isDeliveryPerson) {
        throw Exception('User is not a delivery person');
      }
      if (!deliveryPerson.isActive) {
        throw Exception('Delivery person is not active');
      }

      // Validate order exists
      await _orderRepository.getOrderById(delivery.orderId);

      // Validate delivery data
      if (delivery.pickupAddress.trim().isEmpty) {
        throw Exception('Pickup address is required');
      }
      if (delivery.deliveryAddress.trim().isEmpty) {
        throw Exception('Delivery address is required');
      }
      if (delivery.pickupLatitude < -90 || delivery.pickupLatitude > 90) {
        throw Exception('Invalid pickup latitude');
      }
      if (delivery.pickupLongitude < -180 || delivery.pickupLongitude > 180) {
        throw Exception('Invalid pickup longitude');
      }
      if (delivery.deliveryLatitude < -90 || delivery.deliveryLatitude > 90) {
        throw Exception('Invalid delivery latitude');
      }
      if (delivery.deliveryLongitude < -180 || delivery.deliveryLongitude > 180) {
        throw Exception('Invalid delivery longitude');
      }

      return await _deliveryRepository.createDelivery(delivery);
    } catch (e) {
      throw Exception('Failed to create delivery: ${e.toString()}');
    }
  }
}

class GetDeliveryByIdUseCase {
  final DeliveryRepository _deliveryRepository;

  GetDeliveryByIdUseCase(this._deliveryRepository);

  Future<Delivery> execute(String deliveryId) async {
    try {
      if (deliveryId.isEmpty) {
        throw Exception('Delivery ID is required');
      }
      return await _deliveryRepository.getDeliveryById(deliveryId);
    } catch (e) {
      throw Exception('Failed to get delivery: ${e.toString()}');
    }
  }
}

class GetDeliveriesByPersonUseCase {
  final DeliveryRepository _deliveryRepository;

  GetDeliveriesByPersonUseCase(this._deliveryRepository);

  Future<List<Delivery>> execute(
    String deliveryPersonId, {
    DeliveryStatus? status,
    DateTime? date,
  }) async {
    try {
      if (deliveryPersonId.isEmpty) {
        throw Exception('Delivery person ID is required');
      }
      return await _deliveryRepository.getDeliveriesByDeliveryPerson(
        deliveryPersonId,
        status: status,
        date: date,
      );
    } catch (e) {
      throw Exception('Failed to get deliveries by person: ${e.toString()}');
    }
  }
}

class GetDeliveryByOrderUseCase {
  final DeliveryRepository _deliveryRepository;

  GetDeliveryByOrderUseCase(this._deliveryRepository);

  Future<Delivery?> execute(String orderId) async {
    try {
      if (orderId.isEmpty) {
        throw Exception('Order ID is required');
      }
      return await _deliveryRepository.getDeliveryByOrderId(orderId);
    } catch (e) {
      throw Exception('Failed to get delivery by order: ${e.toString()}');
    }
  }
}

class GetActiveDeliveriesUseCase {
  final DeliveryRepository _deliveryRepository;

  GetActiveDeliveriesUseCase(this._deliveryRepository);

  Future<List<Delivery>> execute({String? deliveryPersonId}) async {
    try {
      return await _deliveryRepository.getActiveDeliveries(
        deliveryPersonId: deliveryPersonId,
      );
    } catch (e) {
      throw Exception('Failed to get active deliveries: ${e.toString()}');
    }
  }
}

class UpdateDeliveryStatusUseCase {
  final DeliveryRepository _deliveryRepository;

  UpdateDeliveryStatusUseCase(this._deliveryRepository);

  Future<Delivery> execute(
    String deliveryId,
    DeliveryStatus status,
    String updatedBy,
  ) async {
    try {
      if (deliveryId.isEmpty) {
        throw Exception('Delivery ID is required');
      }
      if (updatedBy.isEmpty) {
        throw Exception('Updated by user ID is required');
      }
      return await _deliveryRepository.updateDeliveryStatus(
        deliveryId,
        status,
        updatedBy,
      );
    } catch (e) {
      throw Exception('Failed to update delivery status: ${e.toString()}');
    }
  }
}

class UpdateDeliveryLocationUseCase {
  final DeliveryRepository _deliveryRepository;

  UpdateDeliveryLocationUseCase(this._deliveryRepository);

  Future<Delivery> execute(
    String deliveryId,
    String address,
    double latitude,
    double longitude,
  ) async {
    try {
      if (deliveryId.isEmpty) {
        throw Exception('Delivery ID is required');
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
      return await _deliveryRepository.updateDeliveryLocation(
        deliveryId,
        address.trim(),
        latitude,
        longitude,
      );
    } catch (e) {
      throw Exception('Failed to update delivery location: ${e.toString()}');
    }
  }
}

class UpdateEstimatedTimeUseCase {
  final DeliveryRepository _deliveryRepository;

  UpdateEstimatedTimeUseCase(this._deliveryRepository);

  Future<Delivery> execute(
    String deliveryId,
    DateTime estimatedTime,
  ) async {
    try {
      if (deliveryId.isEmpty) {
        throw Exception('Delivery ID is required');
      }
      if (estimatedTime.isBefore(DateTime.now())) {
        throw Exception('Estimated time cannot be in the past');
      }
      return await _deliveryRepository.updateEstimatedTime(
        deliveryId,
        estimatedTime,
      );
    } catch (e) {
      throw Exception('Failed to update estimated time: ${e.toString()}');
    }
  }
}

class GetDeliveryStatsUseCase {
  final DeliveryRepository _deliveryRepository;

  GetDeliveryStatsUseCase(this._deliveryRepository);

  Future<Map<String, dynamic>> execute(
    DateTime startDate,
    DateTime endDate, {
    String? deliveryPersonId,
  }) async {
    try {
      if (startDate.isAfter(endDate)) {
        throw Exception('Start date cannot be after end date');
      }
      return await _deliveryRepository.getDeliveryStats(
        startDate,
        endDate,
        deliveryPersonId: deliveryPersonId,
      );
    } catch (e) {
      throw Exception('Failed to get delivery stats: ${e.toString()}');
    }
  }
}

class GetAverageDeliveryTimeUseCase {
  final DeliveryRepository _deliveryRepository;

  GetAverageDeliveryTimeUseCase(this._deliveryRepository);

  Future<Duration> execute(
    DateTime startDate,
    DateTime endDate, {
    String? deliveryPersonId,
  }) async {
    try {
      if (startDate.isAfter(endDate)) {
        throw Exception('Start date cannot be after end date');
      }
      return await _deliveryRepository.getAverageDeliveryTime(
        startDate,
        endDate,
        deliveryPersonId: deliveryPersonId,
      );
    } catch (e) {
      throw Exception('Failed to get average delivery time: ${e.toString()}');
    }
  }
}

class GetDeliveryStatusHistoryUseCase {
  final DeliveryRepository _deliveryRepository;

  GetDeliveryStatusHistoryUseCase(this._deliveryRepository);

  Future<List<Map<String, dynamic>>> execute(String deliveryId) async {
    try {
      if (deliveryId.isEmpty) {
        throw Exception('Delivery ID is required');
      }
      return await _deliveryRepository.getDeliveryStatusHistory(deliveryId);
    } catch (e) {
      throw Exception('Failed to get delivery status history: ${e.toString()}');
    }
  }
}

class GetDelayedDeliveriesUseCase {
  final DeliveryRepository _deliveryRepository;

  GetDelayedDeliveriesUseCase(this._deliveryRepository);

  Future<List<Delivery>> execute({String? deliveryPersonId}) async {
    try {
      return await _deliveryRepository.getDelayedDeliveries(
        deliveryPersonId: deliveryPersonId,
      );
    } catch (e) {
      throw Exception('Failed to get delayed deliveries: ${e.toString()}');
    }
  }
}