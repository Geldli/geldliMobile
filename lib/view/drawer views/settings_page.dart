// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("..//../../assets/images/cover_profile.png"),
                  fit: BoxFit.cover)
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppBar(
                    backgroundColor: Colors.black,
                    title: Text("Configurações"),
                    actions: [
                      Icon(Icons.more_vert_rounded)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: myBlack,
                  child: Center(
                    child: Text("add"),
                  ),
                )
              ),
            ],
          ),
          Positioned(
            top: 100,
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: myBlack,
                      width: 5
                    ),
                    shape: BoxShape.circle,
                    color: myDarkY
                  ),
                ),
                Text("nome",style: TextStyle(color: myWhite),)
              ],
            ))
        ],
      )
    );
  }
}