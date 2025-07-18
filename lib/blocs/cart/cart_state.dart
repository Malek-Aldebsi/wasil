import 'package:equatable/equatable.dart';
import '../../data/models/product.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [product, quantity];
}

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get total =>
      items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  @override
  List<Object?> get props => [items];
}
