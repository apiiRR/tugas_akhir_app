import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_styles.dart';

class ItemNav extends StatelessWidget {
  const ItemNav({
    super.key,
    required this.icon,
    required this.index,
    required this.isActive,
    required this.label,
    required this.onPressed,
  });

  final void Function()? onPressed;
  final String icon;
  final int index;
  final bool isActive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/$icon",
            width: 28,
            colorFilter: isActive
                ? const ColorFilter.mode(primaryRed, BlendMode.srcIn)
                : null,
          ),
          Text(
            label,
            style: isActive ? kPoppinsSemibold : kPoppinsLight,
          )
        ],
      ),
    );
  }
}
