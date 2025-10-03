import '../entities/product.dart';
import '../core/api_response.dart';

abstract class ProductRepository {
  Future<ApiResponse<Product>> create(Product product);
  Future<ApiResponse<List<Product>>> getAll();
  Future<ApiResponse<Product>> getById(int id);
  Future<ApiResponse<Product>> update(int id, Product product);
  Future<ApiResponse<bool>> delete(int id);
}
