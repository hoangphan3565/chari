import 'package:flutter/material.dart';
import 'package:charity_collaborator_app/components/text_field_container.dart';
import 'package:charity_collaborator_app/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
