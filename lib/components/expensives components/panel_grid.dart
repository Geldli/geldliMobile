// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/expensives%20components/form_new_add.dart';
import 'package:flutter_application_2/ui/text.dart';

class PanelGrid extends StatefulWidget {
  const PanelGrid({super.key});

  @override
  State<PanelGrid> createState() => _PanelGridState();
}

class _PanelGridState extends State<PanelGrid> {
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
                Text("Sign up to discover human stories that deepen your understanding of the world.",style: appBarDesc),
                SizedBox(height: 20),
                FormNew()
              ],
            )
          ],
        ),
      ),
    );
  }
}