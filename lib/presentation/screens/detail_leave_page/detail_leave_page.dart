import 'package:flutter/material.dart';
import 'package:tugas_akhir_project/presentation/widgets/rounded_button.dart';

import '../../utils/app_styles.dart';

class DetailLeavePage extends StatelessWidget {
  const DetailLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryWhite,
        title: Text(
          "Detail Cuti",
          style: kPoppinsBold.copyWith(color: primaryBlack),
        ),
        centerTitle: true,
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
              "Info Pengajuan",
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal Pengajuan",
                          style: kPoppinsMedium.copyWith(fontSize: 16),
                        ),
                        Text(
                          "17 Januari 2023",
                          style: kPoppinsRegular.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jenis Cuti",
                          style: kPoppinsMedium.copyWith(fontSize: 16),
                        ),
                        Text(
                          "Cuti Sakit",
                          style: kPoppinsRegular.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal Cuti",
                          style: kPoppinsMedium.copyWith(fontSize: 16),
                        ),
                        Text(
                          "18 - 19 Juni 2023",
                          style: kPoppinsRegular.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lama Cuti",
                          style: kPoppinsMedium.copyWith(fontSize: 16),
                        ),
                        Text(
                          "2 Hari",
                          style: kPoppinsRegular.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    const Divider(
                      color: secondaryGrey,
                      thickness: 0.6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Catatan",
                          style: kPoppinsMedium.copyWith(fontSize: 16),
                        ),
                        Text(
                          "Sakit Demam",
                          style: kPoppinsRegular.copyWith(fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RoundedButton(
                      onPressed: () {}, text: "Batalkan Pengajuan")),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
