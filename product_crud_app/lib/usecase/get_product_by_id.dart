import '../repository/product_repository.dart';
import '../entities/product.dart';
import '../core/api_response.dart';

class GetProductById {
  final ProductRepository repo;
  GetProductById(this.repo);

  Future<ApiResponse<Product>> call(int id) => repo.getById(id);
}
