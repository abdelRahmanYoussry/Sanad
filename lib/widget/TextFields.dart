import 'package:flutter/material.dart';

import '../Theme/config.dart';

class TextFields extends StatelessWidget {
  final labelText;
  final placeholder;
  final isPasswordTextField;
  final controller;

  const TextFields(
      {Key? key,
      this.labelText,
      this.placeholder,
      this.isPasswordTextField,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTextField(
        context, labelText, placeholder, isPasswordTextField, controller);
  }
}

Widget buildTextField(
    BuildContext context,
    String labelText,
    String placeholder,
    bool isPasswordTextField,
    TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      obscureText: isPasswordTextField ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ))
              : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(color: Config().appaccentColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Config().appaccentColor,
          )),
    ),
  );
}
