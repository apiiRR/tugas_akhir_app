import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tugas_akhir_project/presentation/routes/router.dart';

import '../../../core/bloc/bloc.dart';
import '../../../injector.dart';
import '../../utils/app_styles.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/textfield_with_label.dart';

class UpdatePasswordPage extends StatelessWidget {
  UpdatePasswordPage({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Text(
          "Change Password",
          style: kPoppinsBold.copyWith(color: primaryWhite),
        ),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: primaryWhite,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const TextFieldWithLabel(
                  label: "Password",
                  name: "password",
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextFieldWithLabel(
                  label: "Repeat Password",
                  name: "password_repeat",
                  isPassword: true,
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // TextFieldWithLabel(
                //     label: "Password",
                //     name: "password",
                //     hintText: "*******",
                //     initialValue: data?.password,
                //     isPassword: true,
                //     validator: (String? value) {}),
                SizedBox(
                  height: 6.h,
                ),
                RoundedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      if (_formKey.currentState!.value["email"].toString() ==
                          _formKey.currentState!.value["password_repeat"]
                              .toString()) {
                        locator<ProfileBloc>().add(ProfileEventUpdatePassword(
                            _formKey.currentState!.value["password"]
                                .toString()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: primaryRed,
                            content: Text(
                              "Password not same",
                              style:
                                  kPoppinsRegular.copyWith(color: primaryWhite),
                            )));
                      }
                    }
                  },
                  child: BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: primaryRed,
                          content: Text(
                            state.message,
                            style:
                                kPoppinsRegular.copyWith(color: primaryWhite),
                          ),
                          duration: const Duration(microseconds: 2000),
                        ));
                      } else if (state is ProfileStateComplete) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Update data successfully",
                            style: kPoppinsRegular,
                          ),
                          duration: const Duration(microseconds: 2000),
                        ));
                      }
                    },
                    child: textDefaultRoundedButton("Change Password"),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
