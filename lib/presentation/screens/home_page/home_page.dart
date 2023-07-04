import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tugas_akhir_project/core/bloc/bloc.dart';
import 'package:tugas_akhir_project/presentation/routes/router.dart';

import '../../../core/location.dart';
import '../../../data/repository/firestore service/firestore_services.dart';
import '../../../domain/model/attedance_model.dart';
import '../../../domain/model/profile_model.dart';
import '../../utils/app_styles.dart';
import '../../utils/size_config.dart';
import 'components/current_item.dart';
import 'components/time.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UploadTask? uploadTask;
  bool isLoading = false;

  Future<String> uploadFile(XFile pickFile) async {
    DateTime now = DateTime.now();
    late String urlPhoto;
    final path = 'attedances/${pickFile.name + now.toIso8601String()}';
    final file = File(pickFile.path);

    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putData(file.readAsBytesSync());
      });

      final snapshot = await uploadTask!.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      urlPhoto = urlDownload;

      setState(() {
        uploadTask = null;
      });
    } on FirebaseException catch (_) {}

    return urlPhoto;
  }

  Future<XFile?> pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final attedanceBloc =
        BlocProvider.of<AttedanceBloc>(context, listen: false);
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => context.goNamed(Routes.profilePage),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage("assets/images/profil.jpg"),
                            fit: BoxFit.cover),
                        border: Border.all(color: primaryGrey)),
                  ),
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
                    StreamBuilder<DocumentSnapshot<ProfileModel>>(
                        stream: FirestoreServices().streamCurrentProfile(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              width: 18,
                              height: 18,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                "Data not found",
                                style: kPoppinsRegular.copyWith(fontSize: 18),
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "Cannot reach data",
                                style: kPoppinsRegular.copyWith(fontSize: 18),
                              ),
                            );
                          }

                          final ProfileModel? data = snapshot.data?.data();

                          return Text(
                            data != null ? data.name : "-",
                            style: kPoppinsSemibold.copyWith(fontSize: 18),
                          );
                        })
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            const Time(),
            SizedBox(
              height: 8.h,
            ),
            StreamBuilder<QuerySnapshot<AttedanceModel>>(
                stream: FirestoreServices().streamCurrentAttedance(),
                builder: (context, snapshot) {
                  List<QueryDocumentSnapshot<AttedanceModel>>? dataSnap =
                      snapshot.data?.docs;

                  AttedanceModel? data = dataSnap != null && dataSnap.isNotEmpty
                      ? dataSnap.first.data()
                      : null;

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (isLoading == false) {
                            setState(() {
                              isLoading = true;
                            });
                            checkArea().then((value) {
                              if (value) {
                                pickImage().then((value) async {
                                  if (value != null) {
                                    await uploadFile(value).then((value) =>
                                        attedanceBloc
                                            .add(AttedanceEventClock(value)));
                                  }
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Absent failed because you are outside the area",
                                    style: kPoppinsRegular.copyWith(
                                        color: primaryWhite),
                                  ),
                                  backgroundColor: primaryRed,
                                  duration: const Duration(milliseconds: 1000),
                                ));
                              }

                              setState(() {
                                isLoading = false;
                              });
                            });
                          }
                        },
                        child: BlocListener<AttedanceBloc, AttedanceState>(
                          listener: (context, state) {
                            if (state is AttedanceError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  state.message,
                                  style: kPoppinsRegular.copyWith(
                                      color: primaryWhite),
                                ),
                                backgroundColor: primaryRed,
                                duration: const Duration(milliseconds: 1000),
                              ));
                            }
                          },
                          child: data != null && data.checkOut != null
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 24),
                                  decoration: BoxDecoration(
                                      color: primaryWhite,
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: secondaryGrey, width: 4)),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/icons/complete.png"),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "Completed",
                                        style: kPoppinsMedium.copyWith(
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                      gradient: data == null
                                          ? RadialGradient(
                                              radius: 1.5,
                                              colors: [
                                                  primaryRed,
                                                  primaryRed.withOpacity(0.0)
                                                ])
                                          : RadialGradient(
                                              radius: 1.5,
                                              colors: [
                                                  const Color(0xFF46E4B5),
                                                  const Color(0xFFC2DFD3)
                                                      .withOpacity(0.0)
                                                ]),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: secondaryGrey, width: 4)),
                                  child: Column(
                                    children: [
                                      isLoading == true
                                          ? const SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Padding(
                                                padding: EdgeInsets.all(20),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: primaryWhite,
                                                  strokeWidth: 8,
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Image.asset(
                                                  "assets/icons/clock.png"),
                                            ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        data == null ? "Clock In" : "Clock Out",
                                        style: kPoppinsMedium.copyWith(
                                            color: primaryWhite, fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CurrentItem(
                              icon: "assets/icons/clock_in.svg",
                              time: data != null
                                  ? DateFormat("HH:mm")
                                      .format(data.checkIn.time)
                                  : "--:--",
                              label: "Clock In",
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CurrentItem(
                              icon: "assets/icons/clock_out.svg",
                              time: data != null && data.checkOut != null
                                  ? DateFormat("HH:mm")
                                      .format(data.checkOut!.time)
                                  : "--:--",
                              label: "Clock Out",
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CurrentItem(
                              icon: "assets/icons/total.svg",
                              time: data != null && data.checkOut != null
                                  ? "${data.checkOut!.time.difference(data.checkIn.time).inMinutes.toString()} Min"
                                  : "--:--",
                              label: "Duration",
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }),
          ],
        ),
      )),
    );
  }
}
