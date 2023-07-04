import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injector.dart';
import '../../routes/router.dart';
import '../../utils/app_styles.dart';
import '../../utils/size_config.dart';
import '../../widgets/rounded_button.dart';
import 'components/top_text.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    SharedPreferences sharedPreferences = locator<SharedPreferences>();
    sharedPreferences.setBool('first_launch', false);
    super.initState();
  }

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
          bottom: 40,
          left: kPaddingHorizontal,
          right: kPaddingHorizontal,
          child: RoundedButton(
            onPressed: () {
              context.goNamed(Routes.loginPage);
            },
            child: textDefaultRoundedButton("Get Started"),
          ),
        )
      ],
    ));
  }
}
