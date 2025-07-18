import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_list_app/core/constants.dart';
import '../models/product.dart';

class ApiProvider {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(ApiConstants.productsEndpoint));
    if (response.statusCode == 200) {
      final List products = jsonDecode(response.body)['products'];
      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
