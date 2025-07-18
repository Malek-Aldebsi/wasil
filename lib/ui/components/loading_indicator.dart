import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants.dart';

class LoadingIndicator extends StatelessWidget {
  final int template;
  const LoadingIndicator({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Center(
        child: template == 1
            ? Lottie.asset(
                'assets/images/delivery_animation.json',
                width: width * 0.8,
                height: width * 0.8,
                fit: BoxFit.contain,
              )
            : const CircularProgressIndicator(
                color: AppColors.kMainIcon, strokeWidth: 5));
  }
}
