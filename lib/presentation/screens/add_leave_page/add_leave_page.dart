import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/textfield_with_label.dart';

class AddLeavePage extends StatelessWidget {
  const AddLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryWhite,
        title: Text(
          "Add Leave",
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
