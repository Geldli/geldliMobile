// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/userDatas.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class PanelUserHome extends StatefulWidget {
  final UserDatas userDatas;
  PanelUserHome({super.key, required this.userDatas});

  @override
  State<PanelUserHome> createState() => _PanelUserHomeState();
}

class _PanelUserHomeState extends State<PanelUserHome> {
  
  @override
  Widget build(BuildContext context) {
    var userDatas = Provider.of<UserDatas>(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: userDatas.dados.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: myBlack, 
                        borderRadius: BorderRadius.circular(25)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),   
                      child: ListTile(
                        leading: userDatas.dados[index]['icon'],
                        iconColor: myDarkY,
                        title: Text(userDatas.dados[index]['nome']),
                        titleTextStyle: listViewTitle,
                        subtitle: Text("R\$ ${userDatas.dados[index]['preco']}"),
                        subtitleTextStyle: listViewSubtitle,
                      ),                                    
                    );
                  },)
                )
            ],
          ),
        ),
      )
      
      );
  }
}