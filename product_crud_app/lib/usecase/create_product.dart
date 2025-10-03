import '../repository/product_repository.dart';
import '../entities/product.dart';
import '../core/api_response.dart';

class CreateProduct {
  final ProductRepository repo;
  CreateProduct(this.repo);

  Future<ApiResponse<Product>> call(Product p) => repo.create(p);
}
