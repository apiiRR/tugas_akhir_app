import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/bloc/profile/profile_bloc.dart';
import '../../../../domain/model/profile_model.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/textfield_with_label.dart';

class FormProfile extends StatelessWidget {
  FormProfile({
    super.key,
    required this.data,
  });
  final ProfileModel? data;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            TextFieldWithLabel(
              label: "ID",
              name: "id",
              hintText: "112345",
              initialValue: data?.employeeId,
              isReadOnly: true,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWithLabel(
                label: "Name",
                name: "name",
                hintText: "Rafi Ramadhana",
                initialValue: data?.name,
                validator: FormBuilderValidators.required()),
            const SizedBox(
              height: 10,
            ),
            TextFieldWithLabel(
              label: "Position",
              name: "position",
              hintText: "Officer",
              initialValue: data?.position,
              isReadOnly: true,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWithLabel(
                label: "Email",
                name: "email",
                hintText: "rafiramadhana@gmail.com",
                initialValue: data?.email,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email()
                ])),
            const SizedBox(
              height: 10,
            ),
            TextFieldWithLabel(
                label: "Phone Number",
                name: "phone",
                hintText: "089687********",
                initialValue: data?.phone,
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer()
                ])),
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
                  context.read<ProfileBloc>().add(ProfileEventUpdate(
                      _formKey.currentState!.value["email"].toString(),
                      _formKey.currentState!.value["name"].toString(),
                      _formKey.currentState!.value["phone"].toString()));
                }
              },
              child: textDefaultRoundedButton("Update"),
            ),
          ],
        ));
  }
}
