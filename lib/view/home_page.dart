// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlue,
      drawer: Drawer(
        backgroundColor: myBlack,
        width: 200,
        shape: LinearBorder(),
        surfaceTintColor: myBlack,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 45,horizontal: 10),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: myBlack,
                    elevation: 0,
                  ),
                  onPressed: () {
                  
                  }, 
                  child: Row(
                    children: [
                      Icon(Icons.settings,color: myWhite,size: 20,),
                      SizedBox(width: 8),
                      Text("Configurações",style: textDreawer,)
                    ],
                  )),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myBlack,
                      elevation: 0,
                    ),
                    onPressed: () {
                    
                    }, 
                    child: Row(
                      children: [
                        Icon(Icons.heart_broken,color: myWhite,size: 20),
                        SizedBox(width: 8),
                        Text("Sobre nós",style: textDreawer,)
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        child: Center(
          child: Column(
            children: [
              // app bar
              AppBar(
                title: Text("Bem vindo Bruno!",style: textH1Home),
                backgroundColor: myBlue,
                elevation: 0,
                leading: Builder(
                  builder: (context){
                    return IconButton(onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }, icon: Icon(Icons.more_vert,color: myWhite,));
                  })
                ),

              
            ],
          ),
        ),
      )
    );
  }
}