import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tugas_akhir_project/presentation/routes/router.dart';
import 'package:tugas_akhir_project/presentation/utils/app_styles.dart';

import '../../../data/repository/firestore service/firestore_services.dart';
import '../../../domain/model/leave_model.dart';
import '../../widgets/rounded_button.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryRed,
          title: Text(
            "Leave",
            style: kPoppinsBold.copyWith(color: primaryWhite),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0.5,
        ),
        body: StreamBuilder(
            stream: FirestoreServices().streamLeave(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryRed,
                  ),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Text(
                    "Failed get data",
                    style: kPoppinsRegular,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Failed get data",
                    style: kPoppinsRegular,
                  ),
                );
              }

              List<LeaveModel> leaveData = [];

              for (var element in snapshot.data!.docs) {
                leaveData.add(element.data());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: Container(
                      width: 110,
                      height: 100,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: primaryWhite,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            leaveData.length.toString(),
                            style: kPoppinsBold.copyWith(
                                fontSize: 42, color: primaryRed),
                          ),
                          Text(
                            "Total Leave",
                            style: kPoppinsMedium,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            child: PieChart(
                              baseChartColor: primaryGrey.withOpacity(0.2),
                              centerTextStyle: kPoppinsBold.copyWith(
                                  fontSize: 16, color: primaryBlack),
                              dataMap: {
                                "overdue": double.parse(leaveData
                                    .where((element) => element.type == 1)
                                    .length
                                    .toString())
                              },
                              totalValue:
                                  double.parse(leaveData.length.toString()),
                              centerText: leaveData
                                  .where((element) => element.type == 1)
                                  .length
                                  .toString(),
                              chartRadius: 60,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 10,
                              legendOptions:
                                  const LegendOptions(showLegends: false),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: false,
                                showChartValues: false,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                decimalPlaces: 0,
                              ),
                              colorList: const [primaryRed],
                            ),
                          ),
                          Text(
                            "Sick Leave",
                            style: kPoppinsMedium.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        children: [
                          SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            child: PieChart(
                              baseChartColor: primaryGrey.withOpacity(0.2),
                              centerTextStyle: kPoppinsBold.copyWith(
                                  fontSize: 16, color: primaryBlack),
                              dataMap: {
                                "overdue": double.parse(leaveData
                                    .where((element) => element.type == 2)
                                    .length
                                    .toString())
                              },
                              totalValue:
                                  double.parse(leaveData.length.toString()),
                              centerText: leaveData
                                  .where((element) => element.type == 2)
                                  .length
                                  .toString(),
                              chartRadius: 60,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 10,
                              legendOptions:
                                  const LegendOptions(showLegends: false),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: false,
                                showChartValues: false,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                decimalPlaces: 0,
                              ),
                              colorList: const [primaryRed],
                            ),
                          ),
                          Text(
                            "Annual Leave",
                            style: kPoppinsMedium.copyWith(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RoundedButton(
                      onPressed: () {
                        context.goNamed(Routes.addLeavePage);
                      },
                      child: textDefaultRoundedButton("Apply for leave"),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Leave Data",
                      style: kPoppinsBold.copyWith(fontSize: 18),
                    ),
                  ),
                  ListView.builder(
                      itemCount: leaveData.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              context.goNamed(Routes.detailLeavePage,
                                  extra: leaveData[index]);
                            },
                            child: Card(
                              elevation: 1.5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('EEEE, d MMMM yyyy')
                                          .format(leaveData[index].createdAt),
                                      style: kPoppinsMedium,
                                    ),
                                    const Divider(
                                      color: primaryGrey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.access_time),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Leave Type",
                                                  style: kPoppinsLight,
                                                ),
                                                Text(
                                                  "Sick",
                                                  style: kPoppinsMedium,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Number of Days",
                                              style: kPoppinsLight,
                                            ),
                                            Text(
                                              "${leaveData[index].endLeave.difference(leaveData[index].startLeave).inDays.toString()} days",
                                              style: kPoppinsMedium,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                  const SizedBox(
                    height: 100,
                  )
                ],
              );
            }),
      ),
    );
  }

  SingleChildScrollView sickLeave(
      ScrollController controller, List<LeaveModel> leaveData) {
    final List<LeaveModel> dataSick =
        leaveData.where((element) => element.type == 1).toList();
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
              itemCount: dataSick.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      context.goNamed(Routes.detailLeavePage,
                          extra: dataSick[index]);
                    },
                    child: Card(
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEEE, d MMMM yyyy')
                                  .format(dataSick[index].createdAt),
                              style: kPoppinsMedium,
                            ),
                            const Divider(
                              color: primaryGrey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.access_time),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Leave Type",
                                          style: kPoppinsLight.copyWith(
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "Sick",
                                          style: kPoppinsMedium,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Number of Days",
                                      style:
                                          kPoppinsLight.copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "${dataSick[index].endLeave.difference(dataSick[index].startLeave).inDays.toString()} days",
                                      style: kPoppinsMedium,
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView annualLeave(
      ScrollController controller, List<LeaveModel> leaveData) {
    final List<LeaveModel> dataSick =
        leaveData.where((element) => element.type == 2).toList();
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
              itemCount: dataSick.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Card(
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('EEEE, d MMMM yyyy')
                                .format(dataSick[index].createdAt),
                            style: kPoppinsMedium,
                          ),
                          const Divider(
                            color: primaryGrey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.access_time),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Leave Type",
                                        style: kPoppinsLight.copyWith(
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "Sick",
                                        style: kPoppinsMedium,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Number of Days",
                                    style: kPoppinsLight.copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    "${dataSick[index].endLeave.difference(dataSick[index].startLeave).inDays.toString()} days",
                                    style: kPoppinsMedium,
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
