import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tugas_akhir_project/presentation/utils/app_styles.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Tepat Waktu": 50,
    };
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryWhite,
          title: Text(
            "History",
            style: kPoppinsBold.copyWith(color: primaryBlack),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.5,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
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
                          "25",
                          style: kPoppinsBold.copyWith(
                              fontSize: 42, color: primaryRed),
                        ),
                        Text(
                          "Total Attedance",
                          style: kPoppinsMedium.copyWith(),
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
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: PieChart(
                              baseChartColor: primaryGrey.withOpacity(0.2),
                              centerTextStyle: kPoppinsBold.copyWith(
                                  fontSize: 16, color: primaryBlack),
                              dataMap: dataMap,
                              totalValue: 100,
                              centerText: "50",
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
                        ),
                        Text(
                          "On Time",
                          style: kPoppinsMedium.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: PieChart(
                              baseChartColor: primaryGrey.withOpacity(0.2),
                              centerTextStyle: kPoppinsBold.copyWith(
                                  fontSize: 16, color: primaryBlack),
                              dataMap: dataMap,
                              totalValue: 170,
                              centerText: "25",
                              chartType: ChartType.ring,
                              chartRadius: 60,
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
                        ),
                        Text(
                          "Overdue",
                          style: kPoppinsMedium.copyWith(fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.63,
                minChildSize: 0.63,
                maxChildSize: 0.9,
                builder: (context, controller) => Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 10),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Container(
                          color: primaryWhite,
                          child: Column(
                            children: [
                              Container(
                                decoration:
                                    const BoxDecoration(color: primaryRed),
                                child: TabBar(
                                    labelStyle:
                                        kPoppinsSemibold.copyWith(fontSize: 16),
                                    labelColor: primaryWhite,
                                    unselectedLabelColor:
                                        secondaryGrey.withOpacity(0.7),
                                    indicatorColor: primaryWhite,
                                    tabs: const [
                                      Tab(
                                        text: 'On Time',
                                      ),
                                      Tab(
                                        text: 'Overdue',
                                      )
                                    ]),
                              ),
                              Expanded(
                                child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      SingleChildScrollView(
                                        controller: controller,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                                itemCount: 10,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemBuilder:
                                                    (context, index) => Card(
                                                          elevation: 1.5,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 6),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Monday, 1 March 2023",
                                                                  style:
                                                                      kPoppinsMedium,
                                                                ),
                                                                const Divider(
                                                                  color:
                                                                      primaryGrey,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.access_time),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Check In",
                                                                              style: kPoppinsLight.copyWith(fontSize: 16),
                                                                            ),
                                                                            Text(
                                                                              "08.58",
                                                                              style: kPoppinsMedium,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Check Out",
                                                                          style:
                                                                              kPoppinsLight.copyWith(fontSize: 16),
                                                                        ),
                                                                        Text(
                                                                          "08.58",
                                                                          style:
                                                                              kPoppinsMedium,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Duration",
                                                                          style:
                                                                              kPoppinsLight.copyWith(fontSize: 16),
                                                                        ),
                                                                        Text(
                                                                          "09 Hours 02 Min",
                                                                          style:
                                                                              kPoppinsMedium,
                                                                        )
                                                                      ],
                                                                    )
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
                                      ),
                                      SingleChildScrollView(
                                        controller: controller,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                                itemCount: 10,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemBuilder:
                                                    (context, index) => Card(
                                                          elevation: 1.5,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 6),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Monday, 1 March 2023",
                                                                  style:
                                                                      kPoppinsMedium,
                                                                ),
                                                                const Divider(
                                                                  color:
                                                                      primaryGrey,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.access_time),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Check In",
                                                                              style: kPoppinsLight.copyWith(fontSize: 16),
                                                                            ),
                                                                            Text(
                                                                              "08.58",
                                                                              style: kPoppinsMedium,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Check Out",
                                                                          style:
                                                                              kPoppinsLight.copyWith(fontSize: 16),
                                                                        ),
                                                                        Text(
                                                                          "08.58",
                                                                          style:
                                                                              kPoppinsMedium,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Duration",
                                                                          style:
                                                                              kPoppinsLight.copyWith(fontSize: 16),
                                                                        ),
                                                                        Text(
                                                                          "09 Hours 02 Min",
                                                                          style:
                                                                              kPoppinsMedium,
                                                                        )
                                                                      ],
                                                                    )
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
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
