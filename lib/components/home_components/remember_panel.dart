// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/expense_controller.dart';
import 'package:flutter_application_2/ui/colors.dart';

class PanelRemembers extends StatefulWidget {
  const PanelRemembers({super.key});

  @override
  State<PanelRemembers> createState() => _PanelRemembersState();
}

class _PanelRemembersState extends State<PanelRemembers> {

  ExpenseController _expenseController = ExpenseController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _expenseController.expenseList.length,
                  itemBuilder:(context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: myBlack, 
                      borderRadius: BorderRadius.circular(25)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),  
                    child: ListTile(
                   
                    ),
                    );
                  }, 
                  )
                )
            ],
          ),
        ),
      ),
    );
  }
}