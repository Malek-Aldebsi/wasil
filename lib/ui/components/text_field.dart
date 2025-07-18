import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;

  final bool filled;
  final Color fillColor;
  final Color textColor;
  final double borderRadius;
  final double borderWidth;
  final Color defaultBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;

  final TextAlign textAlign;
  final EdgeInsets? padding;

  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.borderRadius = 12.0,
    this.borderWidth = 0.1,
    this.filled = true,
    this.fillColor = AppColors.kMainTextFieldColor,
    this.textColor = AppColors.kDarkText,
    this.defaultBorderColor = AppColors.transparent,
    this.focusedBorderColor = AppColors.kMainBorder,
    this.errorBorderColor = AppColors.kErrorBorder,
    this.focusNode,
    this.nextFocusNode,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.padding,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? error;
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      onSubmitted: (String value) {
        if (widget.validator != null) {
          setState(() {
            error = widget.validator!(value);
          });
        }
        if (error == null) {
          if (widget.onSubmitted != null) {
            widget.onSubmitted!(value);
          }
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      onChanged: widget.onChanged,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      cursorColor: AppColors.kMainIcon,
      decoration: InputDecoration(
        filled: widget.filled,
        fillColor: widget.fillColor,
        hintText: widget.hint,
        errorText: error,
        hintStyle: const TextStyle(fontSize: 14, color: AppColors.kHintText),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.kErrorText),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,

        // Default border color
        enabledBorder: OutlineInputBorder(
          borderSide: widget.borderWidth == 0
              ? BorderSide.none
              : BorderSide(
                  color: widget.defaultBorderColor, width: widget.borderWidth),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),

        // Border color when focused (on tap)
        focusedBorder: OutlineInputBorder(
          borderSide: widget.borderWidth == 0
              ? BorderSide.none
              : BorderSide(
                  color: widget.focusedBorderColor,
                  width: widget.borderWidth + 1.0),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),

        // Border when there's an error
        errorBorder: OutlineInputBorder(
          borderSide: widget.borderWidth == 0
              ? BorderSide.none
              : BorderSide(
                  color: widget.errorBorderColor,
                  width: widget.borderWidth + 1.0),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),

        // Border when there's an error and focused (on tap)
        focusedErrorBorder: OutlineInputBorder(
          borderSide: widget.borderWidth == 0
              ? BorderSide.none
              : BorderSide(
                  color: widget.errorBorderColor,
                  width: widget.borderWidth + 1),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),

        counterText: '',

        contentPadding: widget.padding,
      ),
      style: TextStyle(
        fontSize: 14,
        color: widget.textColor,
      ),
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign,
    );
  }
}
