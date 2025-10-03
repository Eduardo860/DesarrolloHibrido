import '../adapter/product_adapter.dart';
import '../client/api_client.dart';
import '../client/irest_apiclient.dart';
import '../entities/product.dart';
import '../core/api_response.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final String baseUrl;
  final IRestAPIClient<Map<String, dynamic>, dynamic> client;

  ProductRepositoryImpl({
    this.baseUrl = 'https://fakestoreapi.com',
    IRestAPIClient<Map<String, dynamic>, dynamic>? httpClient,
  }) : client = httpClient ?? APIClient<Map<String, dynamic>, dynamic>();

  String _url(String path) => '$baseUrl$path';

  @override
  Future<ApiResponse<Product>> create(Product product) async {
    try {
      final json = await client.post(_url('/products'), ProductAdapter.toJson(product));
      final p = ProductAdapter.fromJson(json as Map<String, dynamic>);
      return ApiResponse.success(p);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<Product>>> getAll() async {
    try {
      final data = await client.get(_url('/products'));
      final list = (data as List)
          .map((j) => ProductAdapter.fromJson(j as Map<String, dynamic>))
          .toList();
      return ApiResponse.success(list);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<Product>> getById(int id) async {
    try {
      final json = await client.get(_url('/products/$id'));
      final p = ProductAdapter.fromJson(json as Map<String, dynamic>);
      return ApiResponse.success(p);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<Product>> update(int id, Product product) async {
    try {
      final json = await client.put(_url('/products/$id'), ProductAdapter.toJson(product));
      final p = ProductAdapter.fromJson(json as Map<String, dynamic>);
      return ApiResponse.success(p);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<bool>> delete(int id) async {
    try {
      await client.delete(_url('/products/$id'));
      return ApiResponse.success(true);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }
}
