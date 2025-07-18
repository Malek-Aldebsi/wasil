import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';
import 'loading_indicator.dart';

class CustomNetworkImage extends StatefulWidget {
  final String imageUrl;
  final Color placeHolderColor;
  final Color loadingIndicatorColor;
  final Color errorIconColor;
  final double borderRadius;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeHolderColor = AppColors.kSecondaryContainer,
    this.loadingIndicatorColor = AppColors.kMainIcon,
    this.errorIconColor = AppColors.kDarkIcon,
    this.borderRadius = 12.0,
  });

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    Widget img = CachedNetworkImage(
      imageUrl: widget.imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
          child: LoadingIndicator(
        template: 2,
      )),
      errorWidget: (context, url, error) => Center(
        child: Icon(Icons.broken_image, size: 50, color: widget.errorIconColor),
      ),
    );

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.placeHolderColor,
        ),
        clipBehavior: Clip.antiAlias,
        child: img);
  }
}
