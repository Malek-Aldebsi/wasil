import 'package:equatable/equatable.dart';
import '../../data/models/product.dart';

class ProductState extends Equatable {
  final List<Product> allProducts;
  final List<Product> products;
  final bool isLoading;
  final String? error;

  final String? filterCategory;
  final bool sortByPriceAsc;

  const ProductState({
    this.allProducts = const [],
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.filterCategory,
    this.sortByPriceAsc = true,
  });

  ProductState copyWith({
    List<Product>? allProducts,
    List<Product>? products,
    bool? isLoading,
    String? error,
    String? filterCategory,
    bool? sortByPriceAsc,
  }) {
    return ProductState(
      allProducts: allProducts ?? this.allProducts,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterCategory:
          filterCategory == '' ? null : filterCategory ?? this.filterCategory,
      sortByPriceAsc: sortByPriceAsc ?? this.sortByPriceAsc,
    );
  }

  @override
  List<Object?> get props => [
        allProducts,
        products,
        isLoading,
        error,
        filterCategory,
        sortByPriceAsc,
      ];
}
