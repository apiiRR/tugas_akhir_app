import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/profile_model.dart';
import '../../../utils/app_styles.dart';

class Photo extends StatelessWidget {
  const Photo(
      {super.key,
      required this.data,
      required this.onPressedSelectFile,
      required this.onPressedUpload,
      required this.pickedFile});

  final ProfileModel? data;
  final void Function()? onPressedSelectFile;
  final void Function()? onPressedUpload;
  final PlatformFile? pickedFile;

  @override
  Widget build(BuildContext context) {
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
                  image: NetworkImage(data != null && data!.photo != null
                      ? data!.photo!
                      : "https://firebasestorage.googleapis.com/v0/b/mini-project-flutter-aee89.appspot.com/o/files%2Fuser_profile.png?alt=media&token=5e79293e-e1d6-4e1b-a61a-07a80960e313")),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            title: Text(
                              "Profile Image",
                              style: kPoppinsRegular,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    onPressed: onPressedSelectFile,
                                    // {
                                    // await selectFile();
                                    // },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(primaryRed),
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
                            ),
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
                                  onPressed: onPressedUpload,
                                  // async {
                                  // if (pickedFile != null) {
                                  //   Navigator.pop(context);
                                  //   await uploadFile().then((value) =>
                                  //       profile.updatePhoto(value));
                                  // } else {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(
                                  //     const SnackBar(
                                  //       content: Text(
                                  //           "foto belum diunggah"),
                                  //       duration:
                                  //           Duration(seconds: 2),
                                  //     ),
                                  //   );
                                  // }
                                  // },
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
                          color: Theme.of(context).scaffoldBackgroundColor),
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
