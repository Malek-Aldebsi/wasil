import 'package:flutter/material.dart';
import 'package:product_list_app/ui/components/network_image.dart';
import '../../data/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/cart/cart_cubit.dart';
import '../../core/constants.dart';
import '../../routes.dart';
import '../components/button.dart';
import '../components/snack_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final cartCubit = context.read<CartCubit>();
    final cartCount = context.watch<CartCubit>().state.items.length;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // item image + icons
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: CustomNetworkImage(
                    imageUrl: product.thumbnail,
                    placeHolderColor: AppColors.kLightContainer,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.kDarkIcon,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart_rounded,
                                size: 28),
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.cart),
                          ),
                          if (cartCount > 0)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.kMainIcon,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$cartCount',
                                style: const TextStyle(
                                  color: AppColors.kLightText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // item title + category + price + description + add to cart button
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.kLightContainer,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.kDarkContainer.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, -2)),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 24,
                            color: AppColors.kDarkText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.category,
                          style: const TextStyle(
                            color: AppColors.kHintText,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          '\$${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kMainText,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              product.description,
                              style:
                                  const TextStyle(color: AppColors.kDarkText),
                            ),
                          ),
                        ),

                        // Add to cart button
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton.filled(
                            onTap: () {
                              cartCubit.addToCart(product);
                              SnackBarHelper.showInfo(context, 'Added to cart');
                            },
                            label: const Text(
                              'Add to cart',
                              style: TextStyle(
                                color: AppColors.kLightText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
