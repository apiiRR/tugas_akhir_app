import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir_project/presentation/widgets/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/model/leave_model.dart';
import '../../routes/router.dart';
import '../../utils/app_styles.dart';

class DetailLeavePage extends StatelessWidget {
  const DetailLeavePage({super.key, required this.data});

  final LeaveModel data;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

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
            onPressed: () => context.goNamed(Routes.leavePage),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: primaryWhite,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
                color: primaryRed,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Detail Application",
              style: kPoppinsBold.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date of filing",
                          style: kPoppinsLight.copyWith(fontSize: 12),
                        ),
                        Text(
                          DateFormat("EEEE, d MMMM yyyy")
                              .format(data.createdAt),
                          style: kPoppinsMedium,
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type leave",
                          style: kPoppinsLight.copyWith(fontSize: 12),
                        ),
                        Text(
                          data.type == 1 ? "Sick Leave" : "Annual Leave",
                          style: kPoppinsMedium,
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Leave date",
                          style: kPoppinsLight.copyWith(fontSize: 12),
                        ),
                        Text(
                          "${DateFormat('d MMMM yyyy').format(data.startLeave)} - ${DateFormat('d MMMM yyyy').format(data.endLeave)}",
                          style: kPoppinsMedium,
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Long leave",
                          style: kPoppinsLight.copyWith(fontSize: 12),
                        ),
                        Text(
                          "${data.endLeave.difference(data.startLeave).inDays.toString()} days",
                          style: kPoppinsMedium,
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note",
                          style: kPoppinsLight.copyWith(fontSize: 12),
                        ),
                        Text(
                          data.note ?? "-",
                          style: kPoppinsMedium,
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Documents Supporting",
                          style: kPoppinsLight.copyWith(fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            if (data.document != null) {
                              Uri url = Uri.parse(data.document!);
                              _launchUrl(url);
                            }
                          },
                          child: Text(
                            data.document != null ? "Open file" : "-",
                            style: kPoppinsRegular.copyWith(
                                color: data.document != null
                                    ? primaryRed
                                    : primaryBlack),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
