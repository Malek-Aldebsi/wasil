import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/core/constants.dart';
import 'package:product_list_app/ui/components/button.dart';
import 'package:product_list_app/ui/components/network_image.dart';

import '../../blocs/cart/cart_cubit.dart';
import '../../data/models/product.dart';
import '../../routes.dart';
import '../components/snack_bar.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return CustomButton.filled(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetail,
          arguments: product,
        );
      },
      buttonColor: AppColors.kLightButton,
      elevation: 0,
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Product image
                Positioned.fill(
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.kSecondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.kMainBorder,
                          width: 1,
                        ),
                      ),
                      child: CustomNetworkImage(imageUrl: product.thumbnail)),
                ),

                // Cart icon button
                Positioned(
                  bottom: 8,
                  left: 2,
                  child: CustomButton.filled(
                    onTap: () {
                      cartCubit.addToCart(product);
                      SnackBarHelper.showInfo(
                          context, '${product.title} added to cart');
                    },
                    buttonColor: AppColors.kLightButton,
                    isCircular: true,
                    verticalPadding: 2,
                    horizontalPadding: 2,
                    label: const Icon(Icons.add_shopping_cart_rounded,
                        color: AppColors.kDarkIcon, size: 18),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Title & Price
          Row(
            children: [
              Expanded(
                child: Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kDarkText),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '\$${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kMainText,
                ),
              ),
            ],
          ),

          // Description
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.kHintText),
          ),
        ],
      ),
    );
  }
}
