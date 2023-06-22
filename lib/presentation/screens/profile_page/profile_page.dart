import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/textfield_with_label.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 1)),
                      ],
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/mini-project-flutter-aee89.appspot.com/o/files%2Fuser_profile.png?alt=media&token=5e79293e-e1d6-4e1b-a61a-07a80960e313")),
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
                                    title: const Text("Foto Profil"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("*Format dokument jpg, png"),
                                        ElevatedButton(
                                            onPressed: () {
                                              // await selectFile();
                                            },
                                            child: const Text("Unggah"),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      primaryRed),
                                            )),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Batal",
                                            style: TextStyle(color: primaryRed),
                                          )),
                                      TextButton(
                                          onPressed: () async {
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
                                          },
                                          child: const Text(
                                            "Kirim",
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
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              color: primaryRed),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextFieldWithLabel(
              label: "ID",
              name: "id",
              hintText: "112345",
            ),
            const SizedBox(
              height: 10,
            ),
            const TextFieldWithLabel(
              label: "Name",
              name: "name",
              hintText: "Rafi Ramadhana",
            ),
            const SizedBox(
              height: 10,
            ),
            const TextFieldWithLabel(
              label: "Division",
              name: "division",
              hintText: "IT",
            ),
            const SizedBox(
              height: 10,
            ),
            const TextFieldWithLabel(
              label: "Email",
              name: "email",
              hintText: "rafiramadhana@gmail.com",
            ),
            const SizedBox(
              height: 10,
            ),
            const TextFieldWithLabel(
              label: "Phone Number",
              name: "phone",
              hintText: "089687387923",
            ),
            const SizedBox(
              height: 10,
            ),
            const TextFieldWithLabel(
              label: "Password",
              name: "password",
              hintText: "*******",
            ),
            const SizedBox(
              height: 10,
            ),
            const TextFieldWithLabel(
              label: "Address",
              name: "address",
              hintText: "Pecenongan, Jakarta Pusat",
            ),
            const SizedBox(
              height: 30,
            ),
            RoundedButton(
              onPressed: () {},
              text: "Update",
            )
          ],
        ),
      ),
    );
  }
}
