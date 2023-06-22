import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/size_config.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/textfield_with_label.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight! * 0.2,
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: 200,
              color: secondaryRed,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.1,
            ),
            const TextFieldWithLabel(
              label: "Email Address",
              name: "email",
              hintText: "example@gmail.com",
            ),
            const SizedBox(
              height: 20,
            ),
            const TextFieldWithLabel(
              label: "Password",
              name: "password",
              hintText: "***********",
            ),
            const SizedBox(
              height: 40,
            ),
            RoundedButton(
              onPressed: () {},
              text: "Sign In",
            )
          ],
        ),
      ),
    );
  }
}