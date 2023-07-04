import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/bloc/bloc.dart';
import '../../../data/repository/firestore service/firestore_services.dart';
import '../../../domain/model/profile_model.dart';
import '../../routes/router.dart';
import '../../utils/app_styles.dart';
import 'componets/form_profile.dart';
import 'componets/rounded_light_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future<String> uploadFile() async {
    DateTime now = DateTime.now();
    late String urlPhoto;
    if (pickedFile != null) {
      final path = 'profiles/${pickedFile!.name + now.toIso8601String()}';
      final file = File(pickedFile!.path!);

      try {
        final ref = FirebaseStorage.instance.ref().child(path);
        setState(() {
          uploadTask = ref.putData(file.readAsBytesSync());
        });

        final snapshot = await uploadTask!.whenComplete(() {});

        final urlDownload = await snapshot.ref.getDownloadURL();
        print("Download LINK : $urlDownload");
        urlPhoto = urlDownload;

        setState(() {
          uploadTask = null;
        });
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }

    return urlPhoto;
  }

  Future selectFile() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryWhite,
        title: Text(
          "Profile",
          style: kPoppinsBold.copyWith(color: primaryBlack),
        ),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
            onPressed: () => context.goNamed(Routes.homePage),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: primaryBlack,
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
      body: StreamBuilder<DocumentSnapshot<ProfileModel>>(
          stream: FirestoreServices().streamCurrentProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryRed,
              ));
            }

            ProfileModel? data;
            if (snapshot.hasData) {
              data = snapshot.data?.data();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  photo(data),
                  // Photo(
                  //   data: data,
                  //   pickedFile: pickedFile,
                  //   onPressedSelectFile: () async {
                  //     await selectFile();
                  //   },
                  //   onPressedUpload: () async {
                  //     context.pop();
                  //     await uploadFile();
                  //   },
                  // ),
                  SizedBox(
                    height: 8.h,
                  ),
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: primaryRed,
                          content: Text(
                            state.message,
                            style:
                                kPoppinsRegular.copyWith(color: primaryWhite),
                          ),
                          duration: const Duration(milliseconds: 2000),
                        ));
                      } else if (state is ProfileStateComplete) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Update data successfully",
                            style: kPoppinsRegular,
                          ),
                          duration: const Duration(milliseconds: 2000),
                        ));
                      }
                    },
                    child: FormProfile(data: data),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedLightButton(
                    onPressed: () => context.pushNamed(Routes.passwordPage),
                    child: textDefaultRoundedButton("Update Password",
                        color: primaryRed),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget photo(data) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context, listen: false);
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 4, color: Theme.of(context).scaffoldBackgroundColor),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 1)),
              ],
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(data != null &&
                          data.photo != null &&
                          data.photo != ""
                      ? data.photo
                      : "https://firebasestorage.googleapis.com/v0/b/mini-project-flutter-aee89.appspot.com/o/files%2Fuser_profile.png?alt=media&token=5e79293e-e1d6-4e1b-a61a-07a80960e313")),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: uploadTask != null
                  ? Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          color: primaryRed),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(
                          color: primaryWhite,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  title: Text(
                                    "Profile Image",
                                    style: kPoppinsRegular,
                                  ),
                                  content: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async =>
                                                await selectFile()
                                                    .then((value) => setState(
                                                          () {},
                                                        )),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      primaryRed),
                                            ),
                                            child: Text(
                                              "Pick Image",
                                              style: kPoppinsRegular,
                                            )),
                                        if (pickedFile != null)
                                          Text(
                                            pickedFile!.name,
                                            style: kPoppinsRegular,
                                          ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "*Document format jpg, png",
                                          style: kPoppinsRegular,
                                        ),
                                      ],
                                    );
                                  }),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Back",
                                          style: TextStyle(color: primaryRed),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          if (pickedFile != null) {
                                            context.pop();
                                            await uploadFile().then((value) =>
                                                profileBloc.add(
                                                    ProfileEventUpdatePhoto(
                                                        value)));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: primaryRed,
                                                content: Text(
                                                  "foto belum diunggah",
                                                  style:
                                                      kPoppinsRegular.copyWith(
                                                          color: primaryWhite),
                                                ),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text(
                                          "Upload",
                                          style: TextStyle(color: primaryRed),
                                        )),
                                  ],
                                ));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            color: primaryRed),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ))
        ],
      ),
    );
  }
}
