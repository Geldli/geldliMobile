// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/AssetList.dart';
import 'package:flutter_application_2/controller/expense_controller.dart';
import 'package:flutter_application_2/controller/userDatas.dart';
import 'package:flutter_application_2/model/Asset.dart';
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
  //var patrimony;
  //var totalExpensive;
  //var totalAssets;
  List<double> datas = [];
  ExpenseController _expenseController = ExpenseController();
  final int userId = 4;
  
    Future<void> loadExpenses() async {
    try {
      await _expenseController.getExpenseByUserId(userId);
      print('Despesas carregadas: ${_expenseController.expenseList}');
      double totalValue = _expenseController.totalExpensives();
      double totalAssets = Provider.of<AssetList>(context, listen: false).totalAssets();
      double patrimony = totalAssets - totalValue;

      setState(() {
        datas = [patrimony, totalValue, totalAssets];
      });
    } catch (e) {
      print('Erro ao carregar despesas: $e');
    }
  }

  @override
  void initState(){
    loadExpenses();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var userDatas = Provider.of<UserDatas>(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        child: Center(
          child: Column(
            children: [
             // Text("teste" + totalExpensive.toString(), style: TextStyle(color: Colors.white),),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
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
                        subtitle: Text("R\$ ${datas.isNotEmpty ? datas[index].toStringAsFixed(2) : '0.00'}"),
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