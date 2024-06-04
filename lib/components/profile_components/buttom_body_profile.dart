// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtomBodyProfile extends StatefulWidget {
  String label;
  MainAxisAlignment align;
  Widget icon;
  TextStyle style;
  ButtomBodyProfile({
    required this.align,
    required this.label,
    required this.icon,
    required this.style,
    super.key});

  @override
  State<ButtomBodyProfile> createState() => _ButtomBodyProfileState();
}

class _ButtomBodyProfileState extends State<ButtomBodyProfile> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
                      
      }, 
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(195),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        padding: EdgeInsets.all(0),
        elevation: 0,
        foregroundColor: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: widget.align,
        children: [
          widget.icon,
          Text(widget.label, style: widget.style)
        ],
      ));
  }
}