import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tugas_akhir_project/presentation/routes/router.dart';
import 'package:tugas_akhir_project/presentation/utils/app_styles.dart';

import '../../../data/repository/firestore service/firestore_services.dart';
import '../../../domain/model/attedance_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryRed,
          title: Text(
            "History",
            style: kPoppinsBold.copyWith(color: primaryWhite),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0.5,
        ),
        body: StreamBuilder(
            stream: FirestoreServices().streamAttedance(),
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

              List<AttedanceModel> attedanceData = [];

              for (var element in snapshot.data!.docs) {
                attedanceData.add(element.data());
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
                      height: 110,
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
                            attedanceData.length.toString(),
                            style: kPoppinsBold.copyWith(
                                fontSize: 36, color: primaryRed),
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
                  SizedBox(
                    height: 4.h,
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
                                "onTime": double.parse(attedanceData
                                    .where((element) => element.status == 1)
                                    .length
                                    .toString())
                              },
                              totalValue:
                                  double.parse(attedanceData.length.toString()),
                              centerText: attedanceData
                                  .where((element) => element.status == 1)
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
                            "On Time",
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
                                "overdue": double.parse(attedanceData
                                    .where((element) => element.status == 2)
                                    .length
                                    .toString())
                              },
                              totalValue:
                                  double.parse(attedanceData.length.toString()),
                              centerText: attedanceData
                                  .where((element) => element.status == 2)
                                  .length
                                  .toString(),
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
                          Text(
                            "Overdue",
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "History Data",
                      style: kPoppinsBold.copyWith(fontSize: 18),
                    ),
                  ),
                  ListView.builder(
                      itemCount: attedanceData.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              context.goNamed(Routes.detailHistoryPage,
                                  extra: attedanceData[index]);
                            },
                            child: Card(
                              elevation: 1.5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // "Monday, 1 March 2023",
                                      DateFormat('EEEE, d MMMM y').format(
                                          attedanceData[index].checkIn.time),
                                      style: kPoppinsMedium,
                                    ),
                                    const Divider(
                                      color: primaryGrey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  "Check In",
                                                  style: kPoppinsLight,
                                                ),
                                                Text(
                                                  // "08.58",
                                                  DateFormat('HH:mm').format(
                                                      attedanceData[index]
                                                          .checkIn
                                                          .time),
                                                  style: kPoppinsMedium,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Check Out",
                                              style: kPoppinsLight,
                                            ),
                                            Text(
                                              // "08.58",
                                              attedanceData[index].checkOut ==
                                                      null
                                                  ? "--:--"
                                                  : DateFormat('HH:mm').format(
                                                      attedanceData[index]
                                                          .checkOut!
                                                          .time),
                                              style: kPoppinsMedium,
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Status",
                                              style: kPoppinsLight,
                                            ),
                                            Text(
                                              attedanceData[index].status == 1
                                                  ? "On Time"
                                                  : "Overdue",
                                              style: kPoppinsMedium,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              );
            }),
      ),
    );
  }

  // SingleChildScrollView onTime(
  //     ScrollController controller, List<AttedanceModel> data) {
  //   final List<AttedanceModel> dataOntime =
  //       data.where((element) => element.status == 1).toList();
  //   return SingleChildScrollView(
  //     controller: controller,
  //     child: Column(
  //       children: [
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         ListView.builder(
  //             itemCount: dataOntime.length,
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             padding: EdgeInsets.zero,
  //             itemBuilder: (context, index) => InkWell(
  //                   onTap: () {
  //                     context.goNamed(Routes.detailHistoryPage,
  //                         extra: dataOntime[index]);
  //                   },
  //                   child: Card(
  //                     elevation: 1.5,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8)),
  //                     margin: const EdgeInsets.symmetric(
  //                         horizontal: 10, vertical: 6),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 16, vertical: 10),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             // "Monday, 1 March 2023",
  //                             DateFormat('EEEE, d MMMM y')
  //                                 .format(dataOntime[index].checkIn.time),
  //                             style: kPoppinsMedium,
  //                           ),
  //                           const Divider(
  //                             color: primaryGrey,
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   const Icon(Icons.access_time),
  //                                   const SizedBox(
  //                                     width: 10,
  //                                   ),
  //                                   Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         "Check In",
  //                                         style: kPoppinsLight.copyWith(
  //                                             fontSize: 16),
  //                                       ),
  //                                       Text(
  //                                         // "08.58",
  //                                         DateFormat('HH:mm').format(
  //                                             dataOntime[index].checkIn.time),
  //                                         style: kPoppinsMedium,
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                     "Check Out",
  //                                     style:
  //                                         kPoppinsLight.copyWith(fontSize: 16),
  //                                   ),
  //                                   Text(
  //                                     // "08.58",
  //                                     dataOntime[index].checkOut == null
  //                                         ? "--:--"
  //                                         : DateFormat('HH:mm').format(
  //                                             dataOntime[index].checkOut!.time),
  //                                     style: kPoppinsMedium,
  //                                   )
  //                                 ],
  //                               ),
  //                               Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                     "Duration",
  //                                     style:
  //                                         kPoppinsLight.copyWith(fontSize: 16),
  //                                   ),
  //                                   Text(
  //                                     // "09 Hours 02 Min",
  //                                     dataOntime[index].checkOut == null
  //                                         ? "--:--"
  //                                         : "${dataOntime[index].checkOut!.time.difference(dataOntime[index].checkIn.time).inMinutes.toString()} Min",
  //                                     style: kPoppinsMedium,
  //                                   )
  //                                 ],
  //                               )
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 )),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // SingleChildScrollView overdue(
  //     ScrollController controller, List<AttedanceModel> data) {
  //   final List<AttedanceModel> dataOntime =
  //       data.where((element) => element.status == 2).toList();
  //   return SingleChildScrollView(
  //     controller: controller,
  //     child: Column(
  //       children: [
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         ListView.builder(
  //             itemCount: dataOntime.length,
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             padding: EdgeInsets.zero,
  //             itemBuilder: (context, index) => Card(
  //                   elevation: 1.5,
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(8)),
  //                   margin:
  //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: 16, vertical: 10),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           // "Monday, 1 March 2023",
  //                           DateFormat('EEEE, d MMMM y')
  //                               .format(dataOntime[index].checkIn.time),
  //                           style: kPoppinsMedium,
  //                         ),
  //                         const Divider(
  //                           color: primaryGrey,
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 const Icon(Icons.access_time),
  //                                 const SizedBox(
  //                                   width: 10,
  //                                 ),
  //                                 Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(
  //                                       "Check In",
  //                                       style: kPoppinsLight.copyWith(
  //                                           fontSize: 16),
  //                                     ),
  //                                     Text(
  //                                       // "08.58",
  //                                       DateFormat('HH:mm').format(
  //                                           dataOntime[index].checkIn.time),
  //                                       style: kPoppinsMedium,
  //                                     )
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   "Check Out",
  //                                   style: kPoppinsLight.copyWith(fontSize: 16),
  //                                 ),
  //                                 Text(
  //                                   // "08.58",
  //                                   dataOntime[index].checkOut == null
  //                                       ? "--:--"
  //                                       : DateFormat('HH:mm').format(
  //                                           dataOntime[index].checkOut!.time),
  //                                   style: kPoppinsMedium,
  //                                 )
  //                               ],
  //                             ),
  //                             Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   "Duration",
  //                                   style: kPoppinsLight.copyWith(fontSize: 16),
  //                                 ),
  //                                 Text(
  //                                   // "09 Hours 02 Min",
  //                                   dataOntime[index].checkOut == null
  //                                       ? "--:--"
  //                                       : "${dataOntime[index].checkOut!.time.difference(dataOntime[index].checkIn.time).inMinutes.toString()} Min",
  //                                   style: kPoppinsMedium,
  //                                 )
  //                               ],
  //                             )
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 )),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
