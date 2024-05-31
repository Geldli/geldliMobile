// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Expensive.dart';
import 'package:flutter_application_2/model/ExpensiveList.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class PanelList extends StatefulWidget {
  const PanelList({super.key});

  @override
  State<PanelList> createState() => _PanelListState();
}

class _PanelListState extends State<PanelList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensiveList>(builder: (context, value, child) =>
      SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          child: Center(
            child: Column(
              children: [
                Text("Clique no bloco da despesa que deseja editar.",style: listViewTitle),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.listExpensives.length,
                    itemBuilder: (context, index) {
                      Expensive thisExpensive = value.listExpensives[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: myBlack, 
                          borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),   
                        child: ListTile(
                          trailing: Container(
                            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                            decoration: BoxDecoration(
                              color: thisExpensive.colorD,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text("alimentação",style: categoryText),
                          ),
                          title: Text(thisExpensive.titleD),
                          titleTextStyle: listViewTitle,
                        ),                                    
                      );                    
                    },
                    )
                )
              ],
            ),
          ),
        )
      
      ),
    );
  }
}