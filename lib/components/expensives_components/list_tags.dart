// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/expense_controller.dart';
import 'package:flutter_application_2/controller/tag_expense_controller.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Expense.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:provider/provider.dart';

class ListTag extends StatefulWidget {
   final ValueChanged<Tag?> onCategorySelected;
  ListTag({super.key, required this.onCategorySelected});

  @override
  State<ListTag> createState() => _ListTagState();
}

class _ListTagState extends State<ListTag> {

  TagExpenseController _tagExpenseController = TagExpenseController();
  ExpenseController _expenseController = ExpenseController();
  
  late List<bool> colorChangeList;
  late List<Tag> categoryList = [];

  @override
  initState(){
    colorChangeList = [];
    loadTags();
    super.initState();
  }

void loadTags() async {
  await _tagExpenseController.getTagByUserId(4); // Aguarda a conclusão
  setState(() {
    categoryList = _tagExpenseController.tagExpenseList; // Atualiza a lista após o carregamento
      colorChangeList = List<bool>.filled(categoryList.length, false);
      print("Tags carregadas: ${categoryList.length}");  
      
      });
  }


  @override
  Widget build(BuildContext context) {

      if (colorChangeList.length != categoryList.length) {
        colorChangeList = List<bool>.filled(categoryList.length, false);
      }
      print(categoryList.length);

      return SafeArea(
        child: SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              Tag currentTag = categoryList[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      // Deselect all buttons
                      for (int i = 0; i < colorChangeList.length; i++) {
                        colorChangeList[i] = false;
                      }
                      // Select the current button
                      colorChangeList[index] = true;
                    });
                    widget.onCategorySelected(currentTag);

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorChangeList[index] ? myDarkY : myWhite,
                    elevation: 0,
                  ),
                  child: Text(currentTag.titleC, style: TextStyle(color: myBlack),),
                ),
              );
            },
            ),
          )
        );
  }
}