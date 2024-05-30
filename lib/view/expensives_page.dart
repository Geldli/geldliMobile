// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';

class ExpensivesPage extends StatefulWidget {
  const ExpensivesPage({super.key});

  @override
  State<ExpensivesPage> createState() => _ExpensivesPageState();
}

class _ExpensivesPageState extends State<ExpensivesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      backgroundColor: myBlue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myBlue,
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Despesa",
                style: appBarTitle
              ),
              SizedBox(height: 10),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                style: appBarDesc,
                maxLines: 2,
                ),
            ],
          ),
      ),

        bottom: TabBar(
          dividerHeight: 0,
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          labelStyle: tabTextStyle,
          unselectedLabelColor: myWhite,
          unselectedLabelStyle: tabTextStyle,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: myWhite,
          ),
          tabs: [
            Tab(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                child: Text("Meu Painel"),
              ),
              ),
            Tab(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                child: Text("Lembretes"),
              ),
            ),],
        ),     
      ),


    ));
  }
}