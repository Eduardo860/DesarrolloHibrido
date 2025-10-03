import '../repository/product_repository.dart';
import '../entities/product.dart';
import '../core/api_response.dart';

class GetAllProducts {
  final ProductRepository repo;
  GetAllProducts(this.repo);

  Future<ApiResponse<List<Product>>> call() => repo.getAll();
}
