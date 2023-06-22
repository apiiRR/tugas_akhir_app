import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_styles.dart';

class CurrentItem extends StatelessWidget {
  const CurrentItem({
    super.key,
    required this.icon,
    required this.time,
    required this.label,
  });

  final String icon;
  final String time;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          width: 42,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          time,
          style: kPoppinsBold.copyWith(color: primaryBlack, fontSize: 16),
        ),
        Text(
          label,
          style: kPoppinsRegular.copyWith(color: primaryBlack, fontSize: 16),
        )
      ],
    );
  }
}
