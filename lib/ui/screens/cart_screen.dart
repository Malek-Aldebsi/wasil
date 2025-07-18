import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/ui/components/button.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/cart/cart_cubit.dart';
import '../../blocs/cart/cart_state.dart';
import '../../routes.dart';
import '../../core/constants.dart';
import '../components/network_image.dart';
import '../components/snack_bar.dart';
import '../widgets/quantity_selector.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isGuest = authState.status != AuthStatus.authenticated;

    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.kDarkIcon,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: BlocBuilder<CartCubit, CartState>(
            builder: (context, cart) {
              return Row(
                children: [
                  const Text(
                    'Cart',
                    style: TextStyle(
                        color: AppColors.kDarkText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '(${cart.items.length} ${cart.items.length == 1 ? 'item' : 'items'})',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.kDarkText,
                    ),
                  )
                ],
              );
            },
          ),
          backgroundColor: AppColors.kAppBarBackground,
          surfaceTintColor: AppColors.kAppBarBackground,
          shadowColor: AppColors.kAppBarBackground,
          foregroundColor: AppColors.kDarkText,
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, cart) {
            if (cart.items.isEmpty) {
              return const Center(
                  child: Text(
                'Your cart is empty',
                style: TextStyle(
                  color: AppColors.kDarkText,
                  fontSize: 16,
                ),
              ));
            }
            return Column(
              children: [
                // Items List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const SizedBox(),
                    itemBuilder: (ctx, i) {
                      final item = cart.items[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            // Product Image
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: CustomNetworkImage(
                                  placeHolderColor: AppColors.kLightContainer,
                                  imageUrl: item.product.thumbnail),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Title
                                          SizedBox(
                                            width: width * 0.6,
                                            child: Text(
                                              item.product.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.kDarkText,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // Category
                                          Text(
                                            item.product.category,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.kHintText),
                                          ),
                                        ],
                                      ),
                                      // Delete button
                                      IconButton(
                                        icon: const Icon(
                                            Icons.delete_outline_rounded),
                                        color: AppColors.kMainIcon,
                                        onPressed: () => context
                                            .read<CartCubit>()
                                            .removeFromCart(
                                              item.product,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Price
                                      Text(
                                        '\$${item.product.price.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.kMainText,
                                        ),
                                      ),
                                      // Quantity selector
                                      QuantitySelector(
                                        quantity: item.quantity,
                                        onIncrement: () => context
                                            .read<CartCubit>()
                                            .updateQuantity(item.product,
                                                item.quantity + 1),
                                        onDecrement: () => context
                                            .read<CartCubit>()
                                            .updateQuantity(item.product,
                                                item.quantity - 1),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Bottom summary panel
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  decoration: const BoxDecoration(
                    color: AppColors.kMainContainer,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal (${cart.items.length} ${cart.items.length == 1 ? 'item' : 'items'})',
                            style: const TextStyle(
                                color: AppColors.kLightText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${cart.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: AppColors.kLightText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Checkout button
                      CustomButton.filled(
                        onTap: () {
                          if (isGuest) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text(
                                  'Guest Checkout',
                                  style: TextStyle(
                                      color: AppColors.kDarkText,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                content: const Text(
                                  'Please sign up or log in to complete checkout.',
                                  style: TextStyle(
                                      color: AppColors.kDarkText, fontSize: 14),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, Routes.login);
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: AppColors.kMainText,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, Routes.signup);
                                    },
                                    child: const Text(
                                      'Signup',
                                      style: TextStyle(
                                        color: AppColors.kMainText,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            context.read<CartCubit>().clearCart();
                            SnackBarHelper.showInfo(
                                context, 'Checkout complete!');
                            Navigator.pushNamed(context, Routes.products);
                          }
                        },
                        buttonColor: AppColors.kLightButton,
                        label: const Text(
                          'Checkout',
                          style: TextStyle(
                            color: AppColors.kMainText,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
