import 'package:flutter/material.dart';
import 'package:product_list_app/core/constants.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: quantity > 1 ? onDecrement : null,
          icon: const Icon(
            Icons.remove_circle_outline_rounded,
            color: AppColors.kExtraIcon,
          ),
        ),
        Text('$quantity',
            style: const TextStyle(color: AppColors.kMainText, fontSize: 16)),
        IconButton(
          onPressed: onIncrement,
          icon: const Icon(
            Icons.add_circle_outline_rounded,
            color: AppColors.kMainIcon,
          ),
        ),
      ],
    );
  }
}
