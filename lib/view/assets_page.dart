// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/assets_components/panel_grid_assets.dart';
import 'package:flutter_application_2/components/assets_components/panel_list_assets.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
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
                "Ativo",
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
                child: Text("Meus Ativos"),
              ),
            ),],
        ),     
      ),

    body: TabBarView(  
      children: [
        PanelGridA(label: "Para cadastrar um novo ativo, complete todos os campos. Isso ajudará você a manter um registro detalhado e organizado de suas finanças."),
        PanelListA(),
      ],
    ),
    ));
  }
}