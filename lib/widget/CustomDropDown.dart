// ignore_for_file: file_names, deprecated_member_use, must_be_immutable

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hassy/core/utils/shared/app/color_manager.dart';
import 'package:hassy/core/utils/shared/app/values_manager.dart';

class MyCustomDropDown extends StatelessWidget {
  List<DropDownValueModel> dropDownValueList;
  late dynamic validator;
  Widget? label;
  bool? enableSearch = false;
  Function? onChanged;
  Function? onTap;
  bool enableDropDown;
  SingleValueDropDownController controller;
  AutovalidateMode? isAutoValid = AutovalidateMode.disabled;

  MyCustomDropDown({
    Key? key,
    required this.dropDownValueList,
    required this.validator,
    required this.enableDropDown,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.enableSearch = false,
    this.isAutoValid = AutovalidateMode.disabled,
    required this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      isEnabled: enableDropDown,
      dropDownList: dropDownValueList,
      clearOption: true,
      padding: EdgeInsets.zero,
      onChanged: (value) {
        onChanged!(value);
      },
      dropDownItemCount: 5,
      dropdownRadius: 10,
      controller: controller,
      enableSearch: enableSearch!,
      autovalidateMode: isAutoValid,
      listTextStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: 14,
          locale: context.locale,
          fontWeight: FontWeight.bold),
      dropDownIconProperty: IconProperty(
          color: enableDropDown
              ? Theme.of(context).textTheme.subtitle1!.color
              : ColorManager.unSelectedIconButtonColor),
      validator: validator,
      clearIconProperty:
          IconProperty(color: Theme.of(context).textTheme.subtitle1!.color),
      textFieldDecoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.unSelectedIconButtonColor, width: 1),
              borderRadius: BorderRadius.circular(AppSize.size10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).textTheme.bodyText1!.color!,
                  width: 1),
              borderRadius: BorderRadius.circular(AppSize.size10)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).textTheme.bodyText1!.color!, width: 2),
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
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          labelStyle: TextStyle(
              fontSize: 18,
              color: enableDropDown
                  ? ColorManager.mainPrimaryColor4
                  : ColorManager.unSelectedIconButtonColor)),
      textStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          locale: context.locale),
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
