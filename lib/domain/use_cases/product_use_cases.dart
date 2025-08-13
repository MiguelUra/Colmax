import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../repositories/store_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _productRepository;

  GetProductByIdUseCase(this._productRepository);

  Future<Product> execute(String productId) async {
    try {
      if (productId.isEmpty) {
        throw Exception('Product ID is required');
      }
      return await _productRepository.getProductById(productId);
    } catch (e) {
      throw Exception('Failed to get product: ${e.toString()}');
    }
  }
}

class GetProductsByStoreUseCase {
  final ProductRepository _productRepository;

  GetProductsByStoreUseCase(this._productRepository);

  Future<List<Product>> execute(
    String storeId, {
    bool? isActive,
    bool? inStock,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      return await _productRepository.getProductsByStore(
        storeId,
        isActive: isActive,
        inStock: inStock,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      throw Exception('Failed to get store products: ${e.toString()}');
    }
  }
}

class SearchProductsUseCase {
  final ProductRepository _productRepository;

  SearchProductsUseCase(this._productRepository);

  Future<List<Product>> execute(
    String query, {
    String? storeId,
    String? categoryId,
    bool inStock = true,
    int limit = 20,
  }) async {
    try {
      if (query.trim().isEmpty) {
        throw Exception('Search query is required');
      }
      return await _productRepository.searchProducts(
        query.trim(),
        storeId: storeId,
        categoryId: categoryId,
        inStock: inStock,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Failed to search products: ${e.toString()}');
    }
  }
}

class CreateProductUseCase {
  final ProductRepository _productRepository;
  final StoreRepository _storeRepository;

  CreateProductUseCase(this._productRepository, this._storeRepository);

  Future<Product> execute(Product product) async {
    try {
      // Validate store exists
      final store = await _storeRepository.getStoreById(product.storeId);
      if (!store.isActive) {
        throw Exception('Cannot add products to inactive store');
      }

      // Validate product data
      if (product.name.trim().isEmpty) {
        throw Exception('Product name is required');
      }
      if (product.price <= 0) {
        throw Exception('Product price must be greater than 0');
      }
      if (product.stockQuantity < 0) {
        throw Exception('Stock quantity cannot be negative');
      }

      return await _productRepository.createProduct(product);
    } catch (e) {
      throw Exception('Failed to create product: ${e.toString()}');
    }
  }
}

class UpdateProductUseCase {
  final ProductRepository _productRepository;

  UpdateProductUseCase(this._productRepository);

  Future<Product> execute(String productId, Map<String, dynamic> updates) async {
    try {
      if (productId.isEmpty) {
        throw Exception('Product ID is required');
      }

      // Validate updates
      if (updates.containsKey('name') && (updates['name'] as String).trim().isEmpty) {
        throw Exception('Product name cannot be empty');
      }
      if (updates.containsKey('price') && (updates['price'] as double) <= 0) {
        throw Exception('Product price must be greater than 0');
      }
      if (updates.containsKey('stockQuantity') && (updates['stockQuantity'] as int) < 0) {
        throw Exception('Stock quantity cannot be negative');
      }

      return await _productRepository.updateProduct(productId, updates);
    } catch (e) {
      throw Exception('Failed to update product: ${e.toString()}');
    }
  }
}

class UpdateProductStockUseCase {
  final ProductRepository _productRepository;

  UpdateProductStockUseCase(this._productRepository);

  Future<Product> execute(String productId, int newStock) async {
    try {
      if (productId.isEmpty) {
        throw Exception('Product ID is required');
      }
      if (newStock < 0) {
        throw Exception('Stock quantity cannot be negative');
      }

      return await _productRepository.updateProductStock(productId, newStock);
    } catch (e) {
      throw Exception('Failed to update product stock: ${e.toString()}');
    }
  }
}

class GetPopularProductsUseCase {
  final ProductRepository _productRepository;

  GetPopularProductsUseCase(this._productRepository);

  Future<List<Product>> execute({String? storeId, String? categoryId, int limit = 10}) async {
    try {
      return await _productRepository.getPopularProducts(storeId: storeId, categoryId: categoryId, limit: limit);
    } catch (e) {
      throw Exception('Failed to get popular products: ${e.toString()}');
    }
  }
}

class GetLowStockProductsUseCase {
  final ProductRepository _productRepository;

  GetLowStockProductsUseCase(this._productRepository);

  Future<List<Product>> execute(String storeId, {int threshold = 10}) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      return await _productRepository.getLowStockProducts(storeId, threshold: threshold);
    } catch (e) {
      throw Exception('Failed to get low stock products: ${e.toString()}');
    }
  }
}

class GetOutOfStockProductsUseCase {
  final ProductRepository _productRepository;

  GetOutOfStockProductsUseCase(this._productRepository);

  Future<List<Product>> execute(String storeId) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }
      return await _productRepository.getOutOfStockProducts(storeId);
    } catch (e) {
      throw Exception('Failed to get out of stock products: ${e.toString()}');
    }
  }
}

class DeleteProductUseCase {
  final ProductRepository _productRepository;

  DeleteProductUseCase(this._productRepository);

  Future<void> execute(String productId) async {
    try {
      if (productId.isEmpty) {
        throw Exception('Product ID is required');
      }
      await _productRepository.deleteProduct(productId);
    } catch (e) {
      throw Exception('Failed to delete product: ${e.toString()}');
    }
  }
}

class GetProductStatsUseCase {
  final ProductRepository _productRepository;

  GetProductStatsUseCase(this._productRepository);

  Future<Map<String, dynamic>> execute(String storeId) async {
    try {
      if (storeId.isEmpty) {
        throw Exception('Store ID is required');
      }

      final stats = <String, dynamic>{};
      stats['totalProducts'] = await _productRepository.getStoreProductsCount(storeId);
      stats['inStockProducts'] = await _productRepository.getStoreInStockProductsCount(storeId);
      stats['lowStockProducts'] = (await _productRepository.getLowStockProducts(storeId)).length;
      stats['outOfStockProducts'] = (await _productRepository.getOutOfStockProducts(storeId)).length;

      return stats;
    } catch (e) {
      throw Exception('Failed to get product stats: ${e.toString()}');
    }
  }
}