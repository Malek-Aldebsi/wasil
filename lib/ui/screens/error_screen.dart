import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  ErrorScreenState createState() => ErrorScreenState();
}

class ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Lottie.asset(
              'assets/images/error.json',
              width: width * 0.75,
              height: width * 0.75,
              fit: BoxFit.contain,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 50, left: 15, right: 15),
              child: Text(
                'Unable to load products. Please check your network connection and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.kErrorText,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
