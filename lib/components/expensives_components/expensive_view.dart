// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/model/Expense.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ExpensiveView extends StatefulWidget {
  Expense thisExpensive;
  ExpensiveView({required this.thisExpensive,super.key});

  @override
  State<ExpensiveView> createState() => _ExpensiveViewState();
}

class _ExpensiveViewState extends State<ExpensiveView> {
  @override
  Widget build(BuildContext context) {

    DateFormat dateFormat = DateFormat('dd/MM/yy');
    String formattedDate = dateFormat.format(DateTime.parse(widget.thisExpensive.dateToRemember));

    return AlertDialog(
      alignment: AlignmentDirectional.bottomEnd,
      title: Text(widget.thisExpensive.titleD),
      titleTextStyle: dialogH1,
      backgroundColor: myBlue,  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      content: Container(
        height: 120,
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Descrição:    ", style: dialogH2),
                Flexible(
                  child: Container(
                    child: Text(widget.thisExpensive.descriptD,
                    overflow: TextOverflow.ellipsis,
                    style: dialogH3,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categoria:", style: dialogH2),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                  decoration: BoxDecoration(
                    color: widget.thisExpensive.category!.toColor(),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(widget.thisExpensive.category!.titleC, style: categoryText)),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Lembrete:", style: dialogH2),
                Text(formattedDate, style: dialogH3), 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Valor em Reais:", style: dialogH2),
                Text('R\$ ${widget.thisExpensive.valueD.toStringAsFixed(2)}', style: dialogH3),
              ],
            )
          ],
        ),
      ),
    );
  }
}