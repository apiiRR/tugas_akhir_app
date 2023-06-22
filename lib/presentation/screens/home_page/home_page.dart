import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_styles.dart';
import '../../utils/size_config.dart';
import 'components/current_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              image: AssetImage("assets/images/profil.jpg"),
                              fit: BoxFit.cover),
                          border: Border.all(color: primaryGrey)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: kPoppinsRegular.copyWith(fontSize: 16),
                        ),
                        Text(
                          "Rafi Ramadhana",
                          style: kPoppinsSemibold.copyWith(fontSize: 18),
                        )
                      ],
                    )
                  ],
                )),
                SvgPicture.asset("assets/icons/icon-bell.svg")
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 8,
            ),
            RichText(
                text: TextSpan(
                    text: "19:45",
                    style: kPoppinsBold.copyWith(
                        color: primaryBlack, fontSize: 40),
                    children: [
                  TextSpan(
                      text: " PM",
                      style: kPoppinsBold.copyWith(
                          color: primaryBlack, fontSize: 16))
                ])),
            Text(
              "Monday, Sept 12, 2022",
              style: kPoppinsLight.copyWith(color: primaryBlack, fontSize: 16),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                        radius: 1.5,
                        colors: [primaryRed, primaryRed.withOpacity(0.0)]),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: secondaryGrey, width: 4)),
                child: Column(
                  children: [
                    Image.asset("assets/icons/clock.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Clock In",
                      style: kPoppinsMedium.copyWith(
                          color: primaryWhite, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 10,
            ),
            const Row(
              children: [
                Expanded(
                  child: CurrentItem(
                    icon: "assets/icons/clock_in.svg",
                    time: "09:45",
                    label: "Clock In",
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CurrentItem(
                    icon: "assets/icons/clock_out.svg",
                    time: "--:--",
                    label: "Clock Out",
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CurrentItem(
                    icon: "assets/icons/total.svg",
                    time: "--:--",
                    label: "Duration",
                  ),
                )
              ],
            )
          ],
        ),
      )),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () {},
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Home.svg",
                        width: 28,
                        colorFilter: ColorFilter.mode(primaryRed, BlendMode.srcIn),
                      ),
                      Text(
                        'Home',
                        style: kPoppinsSemibold,
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Dashboard.svg",
                        width: 28,
                      ),
                      Text(
                        'History',
                        style: kPoppinsRegular,
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Calendar.svg",
                        width: 28,
                      ),
                      Text(
                        'Leave',
                        style: kPoppinsRegular,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
