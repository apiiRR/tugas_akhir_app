import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/size_config.dart';
import '../../widgets/rounded_button.dart';
import 'components/top_text.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Image.asset(
            "assets/images/intro.png",
            fit: BoxFit.cover,
          ),
        ),
        const Positioned(
          top: 0,
          child: TopText(),
        ),
        Positioned(
          bottom: 60,
          left: kPaddingHorizontal,
          right: kPaddingHorizontal,
          child: RoundedButton(
            onPressed: () {},
            text: "Get Started",
          ),
        )
      ],
    ));
  }
}