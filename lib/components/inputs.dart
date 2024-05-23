// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';

class Input extends StatelessWidget {
  String label;
  String prefixxIcon;
  String suffixText;
  TextEditingController control;
  bool itsPass;
  Input({required this.label, required this.suffixText ,required this.prefixxIcon ,required this.itsPass, required this.control, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: styleHint,
        controller: control,
        obscureText: itsPass,
        decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 20),
        prefixIcon: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Image.asset(prefixxIcon,width: 20,fit: BoxFit.fill,) 
        ),
        suffixText: suffixText,
        suffixStyle: styleHint,
        //borders styling
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: myWhite,
            width: 2.0
            ),
          borderRadius: BorderRadius.circular(25),
          ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: myDarkY,
              width: 2
            ),
          borderRadius: BorderRadius.circular(25),
          ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: myWhite,
              width: 2.0
            ),
          borderRadius: BorderRadius.circular(25),
          ),
          hintText: label,
          hintStyle: styleHint,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Os campos devem ser preenchidos!";
          } else {
            return null;
          }
        });
  }
}
