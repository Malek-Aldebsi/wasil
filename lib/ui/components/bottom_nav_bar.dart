import 'package:flutter/material.dart';
import 'package:product_list_app/core/constants.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String currentScreen;
  const CustomBottomNavBar({
    super.key,
    required this.currentScreen,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  Map<String, Map<String, dynamic>> screens = {
    'Home': {
      'icon': Icons.home_rounded,
      'label': 'Home',
    },
    'Cart': {
      'icon': Icons.grid_view_rounded,
      'label': 'Cart',
    },
    'Products': {
      'icon': Icons.grid_view_rounded,
      'label': 'Products',
    },
    'Settings': {
      'icon': Icons.settings_rounded,
      'label': 'Settings',
    },
  };

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Hero(
      tag: 'bar',
      child: Material(
        color: AppColors.kNavBarBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        elevation: 10,
        child: SizedBox(
          height: height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: screens.entries.map((entry) {
              final isActive = entry.key == widget.currentScreen;
              final icon = entry.value['icon'] as IconData;
              final label = entry.value['label'] as String;
              return Expanded(
                child: InkWell(
                  onTap: () {
                    if (entry.key == 'Products') {
                      Navigator.pushNamed(context, '/products');
                    } else if (entry.key == 'Cart') {
                      Navigator.pushNamed(context, '/cart');
                    }
                  },
                  splashColor: AppColors.kMainOverlayButton,
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.kSecondaryContainer
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon,
                            color: isActive
                                ? AppColors.kMainIcon
                                : AppColors.kExtraIcon),
                        SizedBox(height: height * 0.005),
                        Text(
                          label,
                          style: TextStyle(
                            color: isActive
                                ? AppColors.kMainText
                                : AppColors.kHintText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
