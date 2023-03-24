// ignore_for_file: file_names, deprecated_member_use, must_be_immutable

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class MyCustomDropDown extends StatelessWidget {
  List<DropDownValueModel> dropDownValueList;
  late dynamic validator;
  Widget? label;
  bool? enableSearch = false;
  Function? onChanged;
  Function? onTap;
  bool enableDropDown;
  BorderSide borderSide;
  SingleValueDropDownController controller;
  AutovalidateMode? isAutoValid = AutovalidateMode.disabled;

  MyCustomDropDown({
    Key? key,
    required this.dropDownValueList,
    required this.validator,
    required this.enableDropDown,
    required this.controller,
    required this.borderSide,
    this.onChanged,
    this.onTap,
    this.enableSearch = false,
    this.isAutoValid = AutovalidateMode.disabled,
    required this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: DropDownTextField(
        isEnabled: enableDropDown,
        dropDownList: dropDownValueList,
        clearOption: true,
        padding: EdgeInsets.zero,
        onChanged: (value) {
          onChanged!(value);
        },
        // dropDownItemCount: 5,
        dropdownRadius: 10,
        controller: controller,
        enableSearch: enableSearch!,
        autovalidateMode: isAutoValid,
        listTextStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: 14,
            // locale: context.locale,
            fontWeight: FontWeight.bold),
        dropDownIconProperty: IconProperty(color: Colors.grey),
        validator: validator,
        clearIconProperty:
            IconProperty(color: Theme.of(context).textTheme.subtitle1!.color),
        textFieldDecoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: borderSide,
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: borderSide,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 3),
            ),
            errorStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            // errorText: 'Error',
            label: label,
            fillColor: Colors.transparent,
            filled: true,
            labelStyle: TextStyle(
                fontSize: 18,
                color: enableDropDown ? Colors.black : Colors.grey)),
        textStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,

          // locale: context.locale
        ),
        dropdownColor: Colors.white,
      ),
    );
  }
}
