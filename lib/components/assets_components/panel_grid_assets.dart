// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/assets_components/form_new_add_assets.dart';
import 'package:flutter_application_2/ui/text.dart';

class PanelGridA extends StatefulWidget {
  String label;
  PanelGridA({required this.label,super.key});

  @override
  State<PanelGridA> createState() => _PanelGridAState();
}

class _PanelGridAState extends State<PanelGridA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 35),
      child: Center(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.label,style: appBarDesc),
                SizedBox(height: 20),
                FormNewA()
              ],
            )
          ],
        ),
      ),
    );
  }
}