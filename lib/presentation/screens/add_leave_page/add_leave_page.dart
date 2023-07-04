import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../core/bloc/leave/leave_bloc.dart';
import '../../routes/router.dart';
import '../../utils/app_styles.dart';
import '../../widgets/date_picker_with_label.dart';
import '../../widgets/dropdown_with_label.dart';
import '../../widgets/file_picker_with_label.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/textfield_with_label.dart';

class AddLeavePage extends StatelessWidget {
  AddLeavePage({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

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
        leading: IconButton(
            onPressed: () => context.goNamed(Routes.leavePage),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: primaryBlack,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  DropdownWithLabel(
                    label: "Leave type",
                    name: "type",
                    items: const [
                      {"name": "Sick Leave", "type": 1},
                      {"name": "Annual Leave", "type": 2}
                    ],
                    hintText: "type your leave",
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DatePickerWithLabel(
                    label: "Start Leave",
                    name: "start",
                    hintText: "start your leave",
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DatePickerWithLabel(
                    label: "End Leave",
                    name: "end",
                    hintText: "start your leave",
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const FilePickerWithLabel(
                    label: "Supporting documents",
                    name: "doc",
                    hintText: "add document for supporting your leave",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextFieldWithLabel(
                    label: "Note",
                    name: "note",
                    hintText: "add another note here",
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        context.read<LeaveBloc>().add(LeaveEventAdd(
                              _formKey.currentState!.value["type"],
                              _formKey.currentState!.value["start"],
                              _formKey.currentState!.value["end"],
                              _formKey.currentState!.value["doc"][0],
                              _formKey.currentState!.value["note"],
                            ));
                      }
                    },
                    child: BlocConsumer<LeaveBloc, LeaveState>(
                      listener: (context, state) {
                        if (state is LeaveError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: primaryRed,
                            content: Text(
                              state.message,
                              style:
                                  kPoppinsRegular.copyWith(color: primaryWhite),
                            ),
                            duration: const Duration(milliseconds: 2000),
                          ));
                        } else if (state is LeaveComplete) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Update data successfully",
                              style: kPoppinsRegular,
                            ),
                            duration: const Duration(milliseconds: 2000),
                          ));
                          context.goNamed(Routes.leavePage);
                        }
                      },
                      builder: (context, state) {
                        if (state is LeaveLoading) {
                          return const SizedBox(
                            height: 14,
                            width: 14,
                            child: CircularProgressIndicator(
                              color: primaryWhite,
                            ),
                          );
                        }

                        return textDefaultRoundedButton("Apply");
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
