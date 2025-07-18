import 'package:flutter/material.dart';
import 'package:product_list_app/core/constants.dart';

class CustomDivider extends StatelessWidget {
  final double thickness;
  final double segmentLength;
  final Color color;
  final double
      fillRatio;
  final Axis orientation;

  const CustomDivider({
    super.key,
    this.thickness = 1,
    this.segmentLength = 8,
    this.color = AppColors.kExtraIcon,
    this.fillRatio = 1,
    this.orientation = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final totalLength = orientation == Axis.horizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();

        final segmentCount = (totalLength * fillRatio / segmentLength).floor();

        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: orientation,
          children: List.generate(segmentCount, (_) {
            return SizedBox(
              width: orientation == Axis.horizontal ? segmentLength : thickness,
              height:
                  orientation == Axis.horizontal ? thickness : segmentLength,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
