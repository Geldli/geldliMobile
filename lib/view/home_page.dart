// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/components/home%20components/panel_user.dart';
import 'package:flutter_application_2/model/ExpensiveList.dart';
import 'package:flutter_application_2/model/userDatas.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  String? username;
  HomePage({
    required this.username,
    super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  String userName = "";

  @override
  void initState(){
    Provider.of<ExpensiveList>(context,listen: false).totalExpensives();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDatas>(
      create: (context) => UserDatas(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
        backgroundColor: myBlue,
        //app bar
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              Text("Olá, ${widget.username}!", style: textH1Home),
              ],
            ),
          ),
      
          // tab bar
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
        
        //drawer
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
      
        //body
        
      body: TabBarView(  
        children: [
          PanelUserHome(userDatas: Provider.of<UserDatas>(context)),
          Text("brua")
        ],
      ),
      ),),
    );
  }
}