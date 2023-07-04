import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../utils/app_styles.dart';

class DatePickerWithLabel extends StatelessWidget {
  const DatePickerWithLabel({
    super.key,
    required this.label,
    required this.name,
    this.hintText,
    this.validator,
  });

  final String label;
  final String name;
  final String? hintText;
  final String? Function(DateTime?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kPoppinsRegular.copyWith(fontSize: 14, color: primaryBlack),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
            decoration: BoxDecoration(
                color: primaryGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
            child: FormBuilderDateTimePicker(
              name: name,
              fieldHintText: hintText,
              validator: validator,
              inputType: InputType.date,
              style:
                  kPoppinsRegular.copyWith(fontSize: 14, color: primaryBlack),
              format: DateFormat('EEEE, d MMMM yyyy'),
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                hintText: hintText,
                hintStyle: kPoppinsRegular.copyWith(
                    fontSize: 14, color: primaryBlack.withOpacity(0.5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: primaryRed, width: 2),
                    borderRadius: BorderRadius.circular(8)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: primaryRed, width: 2),
                    borderRadius: BorderRadius.circular(8)),
              ),
            )),
      ],
    );
  }
}
