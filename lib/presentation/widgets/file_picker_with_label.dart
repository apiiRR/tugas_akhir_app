import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../utils/app_styles.dart';

class FilePickerWithLabel extends StatelessWidget {
  const FilePickerWithLabel({
    super.key,
    required this.label,
    required this.name,
    this.hintText,
    this.validator,
  });

  final String label;
  final String name;
  final String? hintText;
  final String? Function(List<PlatformFile>?)? validator;

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
            child: FormBuilderFilePicker(
              name: name,
              validator: validator,
              maxFiles: 1,
              allowMultiple: false,
              allowedExtensions: const ["png", "pdf", "jpg", "jpeg"],
              typeSelectors: const [
                TypeSelector(
                    type: FileType.custom, selector: Icon(Icons.add_circle))
              ],
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
            )
            // FormBuilderDateTimePicker(
            //   name: name,
            //   fieldHintText: hintText,
            //   validator: validator,
            //   inputType: InputType.date,
            //   style:
            //       kPoppinsRegular.copyWith(fontSize: 14, color: primaryBlack),
            //   format: DateFormat('EEEE, d MMMM yyyy'),
            //   decoration: InputDecoration(
            //     isDense: true,
            //     contentPadding:
            //         const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            //     hintText: hintText,
            //     hintStyle: kPoppinsRegular.copyWith(
            //         fontSize: 14, color: primaryBlack.withOpacity(0.5)),
            //     enabledBorder: OutlineInputBorder(
            //         borderSide: const BorderSide(color: Colors.transparent),
            //         borderRadius: BorderRadius.circular(8)),
            //     focusedBorder: OutlineInputBorder(
            //         borderSide: const BorderSide(color: primaryRed, width: 2),
            //         borderRadius: BorderRadius.circular(8)),
            //     border: OutlineInputBorder(
            //         borderSide: const BorderSide(color: primaryRed, width: 2),
            //         borderRadius: BorderRadius.circular(8)),
            //   ),
            // )
            ),
      ],
    );
  }
}
