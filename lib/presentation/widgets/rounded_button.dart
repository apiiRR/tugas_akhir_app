import 'package:flutter/material.dart';

import '../utils/app_styles.dart';
import '../utils/size_config.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.onPressed, required this.text});

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(SizeConfig.screenWidth!, 50),
            backgroundColor: primaryRed,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: primaryWhite),
                borderRadius: BorderRadius.circular(12))),
        child: Text(
          text,
          style: kPoppinsBold.copyWith(fontSize: 16, color: primaryWhite),
        ));
  }
}
