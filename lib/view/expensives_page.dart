// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/expensives_components/panel_grid.dart';
import 'package:flutter_application_2/components/expensives_components/panel_list.dart';
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
            ],
          ),
      ),

        bottom: TabBar(
          dividerHeight: 0,
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          labelStyle: tabTextStyle2,
          indicatorColor: myDarkY,
          unselectedLabelColor: myWhite,
          unselectedLabelStyle: tabTextStyle,
          tabs: [
            Tab(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                child: Text("Visão Geral"),
              ),
              ),
            Tab(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                child: Text("Minhas Despesas"),
              ),
            ),],
        ),     
      ),

    body: TabBarView(  
      children: [
        PanelGrid(label: "Sign up to discover human stories that deepen your understanding of the world.",modo: 1),
        PanelList(),
      ],
    ),
    ));
  }
}