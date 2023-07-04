import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_styles.dart';

class Time extends StatefulWidget {
  const Time({Key? key}) : super(key: key);

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  var now = DateTime.now();
  Timer? timer;
  var jam = '';
  var detik = '';
  void startJam() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      var tgl = DateTime.now();
      var formatedJam = DateFormat.Hm().format(tgl);
      var formatedDetik = DateFormat("ss").format(tgl);
      setState(() {
        jam = formatedJam;
        detik = formatedDetik;
      });
    });
  }

  @override
  void initState() {
    if (mounted) {
      startJam();
    } else {
      return;
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return jam == ''
        ? Text(
            "--:--",
            style: kPoppinsBold.copyWith(color: primaryBlack, fontSize: 42),
          )
        : Column(
            children: [
              RichText(
                  text: TextSpan(
                      text: jam,
                      style: kPoppinsBold.copyWith(
                          color: primaryBlack, fontSize: 36),
                      children: [
                    TextSpan(
                        text: " $detik",
                        style: kPoppinsBold.copyWith(
                            color: primaryBlack, fontSize: 16))
                  ])),
              Text(
                DateFormat('EEEE, dd MMMM yyyy').format(now),
                style: kPoppinsLight.copyWith(color: primaryBlack),
              ),
            ],
          );
    // return Text(
    //   jam,
    //   style: kPoppinsBold.copyWith(color: primaryBlack, fontSize: 40),
    // );
  }
}
