import '../repository/product_repository.dart';
import '../core/api_response.dart';

class DeleteProduct {
  final ProductRepository repo;
  DeleteProduct(this.repo);

  Future<ApiResponse<bool>> call(int id) => repo.delete(id);
}

