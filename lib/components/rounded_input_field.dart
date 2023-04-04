import 'dart:async';

import 'package:flutter/material.dart';
import 'package:librarymanagement/components/text_field_container.dart';
import 'package:librarymanagement/constants.dart';

class RounderInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RounderInputField({
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
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
