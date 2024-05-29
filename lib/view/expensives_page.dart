// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';

class ExpensivesPage extends StatefulWidget {
  const ExpensivesPage({super.key});

  @override
  State<ExpensivesPage> createState() => _ExpensivesPageState();
}

class _ExpensivesPageState extends State<ExpensivesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlue,
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                //title of page app bar?
                //text
                //buttom
                //expensives planes
                //expensives list
              )

            ],
          ),
        ),
      ),
    );
  }
}