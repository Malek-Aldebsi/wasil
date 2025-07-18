import '../models/product.dart';
import '../providers/api_provider.dart';

class ProductRepository {
  final ApiProvider apiProvider;

  ProductRepository(this.apiProvider);

  Future<List<Product>> getAllProducts() => apiProvider.fetchProducts();
}
