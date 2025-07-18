import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';
import '../../data/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(const ProductState());

  Future<void> fetchProducts() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final products = await repository.getAllProducts();
      emit(state.copyWith(
          allProducts: products, products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _apply() {
    var list = state.allProducts;

    // filter by category
    if (state.filterCategory != null) {
      list = list.where((p) => p.category == state.filterCategory).toList();
    }

    // sort by price
    list.sort((a, b) => state.sortByPriceAsc
        ? a.price.compareTo(b.price)
        : b.price.compareTo(a.price));

    emit(state.copyWith(products: list));
  }

  // user chooses a category (or `null` to clear)
  void filterByCategory(String? category) {
    category ??= '';
    emit(state.copyWith(filterCategory: category));
    _apply();
  }

  // user toggles price sort order
  void sortByPrice() {
    emit(state.copyWith(sortByPriceAsc: !state.sortByPriceAsc));
    _apply();
  }
}
