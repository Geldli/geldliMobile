// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/text.dart';

class Input extends StatelessWidget {
  String label;
  TextEditingController control;
  Input({required this.label, required this.control, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: control,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
