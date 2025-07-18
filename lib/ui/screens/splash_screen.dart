import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/product/product_cubit.dart';
import '../../core/constants.dart';
import '../../routes.dart';
import '../components/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final productCubit = context.read<ProductCubit>();

    productCubit.fetchProducts().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, Routes.products);
      });
    }).catchError((error) {
      Navigator.pushReplacementNamed(context, Routes.error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            LoadingIndicator(
              template: 1,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text(
                'Wasil Store',
                style: TextStyle(
                    color: AppColors.kMainText,
                    fontSize: 32,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
