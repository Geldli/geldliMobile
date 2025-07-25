// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';

class InputProfile extends StatelessWidget {
  TextEditingController control;
  bool itsPass;
  InputProfile({required this.itsPass, required this.control, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: "xxx",
        style: styleHintRead,
        obscureText: itsPass,
        readOnly: true,
        //styling
        decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.fromLTRB(20, 12, 20, 12),
        filled: true,
        fillColor: myBlue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none
        ),
        ),
    );
  }
}
