import 'package:flutter/material.dart';
import 'package:librarymanagement/components/text_field_container.dart';
import 'package:librarymanagement/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedPasswordField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: true,
      decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none),
    ));
  }
}
