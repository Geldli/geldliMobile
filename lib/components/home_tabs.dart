// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  //TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
  return DefaultTabController(
  length: 3,
  child: Scaffold(
    backgroundColor: myBlue,
    appBar: AppBar(
      backgroundColor: myBlue,
      flexibleSpace: Container(
        padding: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Builder(
                  builder: (context){
                    return IconButton(onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }, icon: Icon(Icons.more_vert,color: myWhite,));
                  }),
            Text("  Olá, Bruno!",style: textH1Home),
          ],
        )
      ),
      bottom: TabBar(
        dividerHeight: 0,
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        labelStyle: tabTextStyle,
        unselectedLabelColor: myWhite,
        unselectedLabelStyle: tabTextStyle,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: myWhite
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
    body: TabBarView(

      children: [
        Icon(Icons.flight, size: 350),
        Icon(Icons.directions_transit, size: 350),
      ],
    ),
  ),
);
  }
}