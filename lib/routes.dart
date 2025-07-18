import 'package:flutter/material.dart';
import 'ui/screens/error_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/signup_screen.dart';
import 'ui/screens/product_list_screen.dart';
import 'ui/screens/product_detail_screen.dart';
import 'ui/screens/cart_screen.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const products = '/products';
  static const productDetail = '/productDetail';
  static const cart = '/cart';
  static const error = '/error';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case products:
        return MaterialPageRoute(builder: (_) => const ProductListScreen());
      case productDetail:
        return MaterialPageRoute(
          builder: (_) => const ProductDetailScreen(),
          settings: settings,
        );
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case error:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
