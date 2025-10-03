import '../repository/product_repository.dart';
import '../entities/product.dart';
import '../core/api_response.dart';

class UpdateProduct {
  final ProductRepository repo;
  UpdateProduct(this.repo);

  Future<ApiResponse<Product>> call(int id, Product p) => repo.update(id, p);
}
