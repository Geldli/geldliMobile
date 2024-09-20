import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/CategoryList.dart';
import 'package:flutter_application_2/controller/ExpensiveList.dart';
import 'package:provider/provider.dart';

class ss extends StatefulWidget {
  const ss({super.key});

  @override
  State<ss> createState() => _ssState();
}

class _ssState extends State<ss> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpensiveList, CategoryList>(builder: (context, value, value2, child) {
      return Container(

      );
    },);
  }
}