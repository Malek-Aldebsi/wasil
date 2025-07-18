import 'package:flutter/material.dart';

import '../../core/constants.dart';


class CustomContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? backgroundImage;
  final BoxFit? imageFit;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CustomContainer._({
    required this.child,
    required this.padding,
    required this.borderRadius,
    this.backgroundColor,
    this.backgroundImage,
    this.imageFit,
    this.borderColor,
    this.borderWidth = 1.0,
    Key? key,
  }) : super(key: key);

  // Filled container with background color
  factory CustomContainer.filled({
    required Widget child,
    Color backgroundColor = AppColors.kMainContainer,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    double borderRadius = 12.0,
  }) {
    return CustomContainer._(
      backgroundColor: backgroundColor,
      padding: padding,
      borderRadius: borderRadius,
      child: child,
    );
  }

  // Outlined container with border
  factory CustomContainer.outlined({
    required Widget child,
    Color borderColor = AppColors.kMainBorder,
    Color backgroundColor = AppColors.kMainContainer,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    double borderRadius = 12.0,
    double borderWidth = 1.0,
  }) {
    return CustomContainer._(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      padding: padding,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      child: child,
    );
  }

  // Container with image background
  factory CustomContainer.withImage({
    required Widget child,
    required String imageUrl,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
    double borderRadius = 12.0,
    Color? borderColor,
    double borderWidth = 1.0,
    BoxFit imageFit = BoxFit.cover,
  }) {
    return CustomContainer._(
      backgroundImage: imageUrl,
      padding: padding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      imageFit: imageFit,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        image: backgroundImage != null
            ? DecorationImage(
                image: NetworkImage(backgroundImage!),
                fit: imageFit,
              )
            : null,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: child,
    );
  }
}
