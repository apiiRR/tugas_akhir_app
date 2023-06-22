import 'package:flutter/material.dart';

import '../../../utils/app_styles.dart';
import '../../../utils/size_config.dart';

class TopText extends StatelessWidget {
  const TopText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight! * 0.3,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFFE44646),
                const Color(0xFFE44646).withOpacity(0.0)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.5, 1.0])),
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.05),
          child: Column(
            children: [
              Text(
                "Find the best\nattedance experience\nwith us",
                style: kPoppinsBold.copyWith(color: primaryWhite, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}