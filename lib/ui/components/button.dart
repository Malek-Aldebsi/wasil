import 'package:flutter/material.dart';

import '../../core/constants.dart';


class CustomButton extends StatefulWidget {
  final Widget label;
  final VoidCallback? onTap;
  final Color buttonColor;
  final ImageProvider? bgImage;
  final Color? borderColor;
  final Color overlayColor;
  final double borderRadius;
  final double? borderWidth;
  final double horizontalPadding;
  final double verticalPadding;
  final double elevation;
  final bool isCircular;

  const CustomButton._({
    required this.label,
    required this.onTap,
    required this.buttonColor,
    this.bgImage,
    required this.overlayColor,
    required this.borderRadius,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.elevation,
    required this.isCircular,
    this.borderWidth,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  factory CustomButton.filled({
    required Widget label,
    VoidCallback? onTap,
    Color buttonColor = AppColors.kMainButton,
    Color overlayColor =AppColors.kMainOverlayButton,
    double borderRadius = 12.0,
    double horizontalPadding = 16.0,
    double verticalPadding = 14.0,
    double elevation = 2.0,
    bool isCircular = false,
  }) {
    return CustomButton._(
      label: label,
      onTap: onTap,
      buttonColor: buttonColor,
      overlayColor: overlayColor,
      borderRadius: borderRadius,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      elevation: elevation,
      isCircular: isCircular,
    );
  }

  factory CustomButton.withImageBg({
    required Widget label,
    required ImageProvider image,
    VoidCallback? onTap,
    Color overlayColor = AppColors.kMainOverlayButton,
    double borderRadius = 12.0,
    double horizontalPadding = 16.0,
    double verticalPadding = 14.0,
    double elevation = 2.0,
    bool isCircular = false,
  }) {
    return CustomButton._(
      label: label,
      onTap: onTap,
      buttonColor: AppColors.transparent,
      bgImage: image,
      overlayColor: overlayColor,
      borderRadius: borderRadius,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      elevation: elevation,
      isCircular: isCircular,
    );
  }

  factory CustomButton.outlined({
    required Widget label,
    VoidCallback? onTap,
    Color borderColor = AppColors.kMainBorder,
    Color buttonColor = AppColors.transparent,
    Color overlayColor = AppColors.kMainOverlayButton,
    double borderRadius = 12.0,
    double borderWidth = 1.0,
    double horizontalPadding = 16.0,
    double verticalPadding = 14.0,
    double elevation = 0.0,
    bool isCircular = false,
  }) {
    return CustomButton._(
      label: label,
      onTap: onTap,
      buttonColor: buttonColor,
      overlayColor: overlayColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      elevation: elevation,
      isCircular: isCircular,
      borderColor: borderColor,
    );
  }

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _setScale(bool pressed) {
    setState(() {
      _scale = pressed ? 0.95 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _setScale(true),
      onPointerUp: (_) => _setScale(false),
      onPointerCancel: (_) => _setScale(false),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            elevation: widget.elevation,
            padding: EdgeInsets.zero,
            backgroundColor: widget.buttonColor,
            foregroundColor: widget.overlayColor,
            shape: widget.isCircular
                ? const CircleBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    side: widget.borderColor != null
                        ? BorderSide(
                            color: widget.borderColor!,
                            width: widget.borderWidth ?? 1.0)
                        : BorderSide.none,
                  ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.bgImage != null)
                Ink(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.bgImage!,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  child: Container(),
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding,
                  vertical: widget.verticalPadding,
                ),
                child: widget.label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
