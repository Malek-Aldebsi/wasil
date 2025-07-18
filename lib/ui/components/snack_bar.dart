import 'package:flutter/material.dart';

import '../../core/constants.dart';

class SnackBarHelper {
  static void showOverlay(
    BuildContext context, {
    required String message,
    Color backgroundColor = AppColors.kMainContainer,
    IconData? icon,
    bool atBottom = true,
    int duration = 3,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: atBottom ? null : MediaQuery.of(context).padding.top + 20,
        bottom: atBottom ? MediaQuery.of(context).padding.bottom + 20 : null,
        left: 16,
        right: 16,
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (icon != null) Icon(icon, color: AppColors.kLightIcon),
                if (icon != null) const SizedBox(width: 10),
                Expanded(
                  child: Text(message,
                      style: const TextStyle(color: AppColors.kLightText)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: duration)).then((_) {
      overlayEntry.remove();
    });
  }

  static void showInfo(BuildContext context, String message) {
    showOverlay(
      context,
      message: message,
      backgroundColor: AppColors.kMainContainer,
      icon: Icons.info,
    );
  }

  static void showError(BuildContext context, String message) {
    showOverlay(
      context,
      message: message,
      backgroundColor: AppColors.kDangerContainer,
      icon: Icons.error,
    );
  }
}
