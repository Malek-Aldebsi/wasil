import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';
import '../../data/models/product.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addToCart(Product product) {
    final index =
        state.items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      final updatedItem = state.items[index].copyWith(
        quantity: state.items[index].quantity + 1,
      );
      final updatedItems = [...state.items]..[index] = updatedItem;
      emit(CartState(items: updatedItems));
    } else {
      emit(CartState(
          items: [...state.items, CartItem(product: product, quantity: 1)]));
    }
  }

  void removeFromCart(Product product) {
    emit(CartState(
        items: state.items
            .where((item) => item.product.id != product.id)
            .toList()));
  }

  void updateQuantity(Product product, int newQty) {
    if (newQty <= 0) return;
    final index =
        state.items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      final updatedItem = state.items[index].copyWith(quantity: newQty);
      final updatedItems = [...state.items]..[index] = updatedItem;
      emit(CartState(items: updatedItems));
    }
  }

  void clearCart() {
    emit(const CartState(items: []));
  }
}
