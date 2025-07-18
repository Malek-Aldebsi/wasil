import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/core/constants.dart';
import 'package:product_list_app/ui/components/bottom_nav_bar.dart';
import '../../blocs/cart/cart_cubit.dart';
import '../../blocs/product/product_cubit.dart';
import '../../blocs/product/product_state.dart';
import '../../routes.dart';
import '../components/button.dart';
import '../components/divider.dart';
import '../components/loading_indicator.dart';
import '../widgets/product_card.dart';
import 'package:popover/popover.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    final cartCount = context.watch<CartCubit>().state.items.length;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
            const CustomBottomNavBar(currentScreen: 'Products'),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          // derive unique categories
                          final cats = state.allProducts
                              .map((p) => p.category)
                              .toSet()
                              .toList();
                          return Builder(
                            builder: (context) => IconButton(
                              onPressed: () {
                                showPopover(
                                  context: context,
                                  bodyBuilder: (context) {
                                    return ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      children: [
                                        SizedBox(
                                          width: width * 0.3,
                                          child: CustomButton.filled(
                                              buttonColor:
                                                  AppColors.kLightButton,
                                              elevation: 0,
                                              borderRadius: 0,
                                              onTap: () {
                                                cubit.filterByCategory(null);
                                                Navigator.of(context).pop();
                                              },
                                              label: const Text(
                                                'All',
                                                style: TextStyle(
                                                    color: AppColors.kDarkText,
                                                    fontSize: 12),
                                              )),
                                        ),
                                        for (String cat in cats) ...[
                                          SizedBox(
                                            width: width * 0.3,
                                            child: CustomDivider(
                                              color: AppColors.kExtraIcon
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.3,
                                            child: CustomButton.filled(
                                                buttonColor:
                                                    AppColors.kLightButton,
                                                elevation: 0,
                                                borderRadius: 0,
                                                onTap: () {
                                                  cubit.filterByCategory(cat);
                                                  Navigator.of(context).pop();
                                                },
                                                label: Text(
                                                  cat,
                                                  style: const TextStyle(
                                                      color:
                                                          AppColors.kDarkText,
                                                      fontSize: 12),
                                                )),
                                          ),
                                        ]
                                      ],
                                    );
                                  },
                                  width: width * 0.3,
                                  height: height * 0.2,
                                  backgroundColor: AppColors.kLightContainer,
                                  direction: PopoverDirection.bottom,
                                  arrowDyOffset: 0,
                                );
                              },
                              icon: const Icon(
                                Icons.filter_alt_rounded,
                                size: 28,
                              ),
                            ),
                          );
                        },
                      ),
                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              cubit.sortByPrice();
                            },
                            icon: const Icon(Icons.swap_vert_rounded, size: 28),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Wasil Store',
                  style: TextStyle(
                      color: AppColors.kDarkText,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_rounded, size: 28),
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
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.kAppBarBackground,
          surfaceTintColor: AppColors.kAppBarBackground,
          shadowColor: AppColors.kAppBarBackground,
          foregroundColor: AppColors.kDarkText,
        ),
        body: BlocProvider.value(
          value: cubit,
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                    child: LoadingIndicator(
                  template: 2,
                ));
              }
              if (state.error != null) {
                return Center(child: Text('Error: ${state.error}'));
              }

              final products = state.products;
              return Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => cubit.fetchProducts(),
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: products.length,
                        itemBuilder: (ctx, i) {
                          return ProductCard(product: products[i]);
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
