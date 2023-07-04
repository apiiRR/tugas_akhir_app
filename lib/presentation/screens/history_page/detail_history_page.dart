import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../domain/model/attedance_model.dart';
import '../../routes/router.dart';
import '../../utils/app_styles.dart';

class DetailHistoryPage extends StatelessWidget {
  const DetailHistoryPage({super.key, required this.data});

  final AttedanceModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Text(
          "Detail",
          style: kPoppinsBold.copyWith(color: primaryWhite),
        ),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
            onPressed: () => context.goNamed(Routes.historyPage),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: primaryWhite,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detail Check-In",
                  style: kPoppinsBold,
                ),
                Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 200,
                          width: 100.w,
                          child: Image.network(
                            data.checkIn.photo,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Status",
                                  style: kPoppinsMedium,
                                ),
                                Text(
                                  "On Time",
                                  style: kPoppinsRegular,
                                )
                              ],
                            ),
                            const Divider(
                              color: primaryGrey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Time",
                                  style: kPoppinsMedium,
                                ),
                                Text(
                                  DateFormat.Hm().format(data.checkIn.time),
                                  style: kPoppinsRegular,
                                )
                              ],
                            ),
                            const Divider(
                              color: primaryGrey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date",
                                  style: kPoppinsMedium,
                                ),
                                Text(
                                  DateFormat("EEEE, d MMMM yyyy")
                                      .format(data.checkIn.time),
                                  style: kPoppinsRegular,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detail Check-Out",
                  style: kPoppinsBold,
                ),
                if (data.checkOut != null)
                  Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 200,
                            width: 100.w,
                            child: Image.network(
                              data.checkIn.photo,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Status",
                                    style: kPoppinsMedium,
                                  ),
                                  Text(
                                    "On Time",
                                    style: kPoppinsRegular,
                                  )
                                ],
                              ),
                              const Divider(
                                color: primaryGrey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Time",
                                    style: kPoppinsMedium,
                                  ),
                                  Text(
                                    DateFormat.Hm().format(data.checkIn.time),
                                    style: kPoppinsRegular,
                                  )
                                ],
                              ),
                              const Divider(
                                color: primaryGrey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date",
                                    style: kPoppinsMedium,
                                  ),
                                  Text(
                                    DateFormat("EEEE, d MMMM yyyy")
                                        .format(data.checkIn.time),
                                    style: kPoppinsRegular,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
