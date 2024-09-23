// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/CategoryList.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:provider/provider.dart';

class ListTag extends StatefulWidget {
  const ListTag({super.key});

  @override
  State<ListTag> createState() => _ListTagState();
}

class _ListTagState extends State<ListTag> {

  late List<bool> colorChangeList;


  @override
  initState(){
    colorChangeList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryList>(builder: (context, value, child) {

      if (colorChangeList.length != value.listCategory.length) {
        colorChangeList = List<bool>.filled(value.listCategory.length, false);
      }

      return SafeArea(
        child: SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: value.listCategory.length,
            itemBuilder: (context, index) {
              Tag currentTag = value.listCategory[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      colorChangeList[index] = !colorChangeList[index];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorChangeList[index] ? currentTag.colorC : myWhite,
                    elevation: 0,
                  ),
                  child: Text(currentTag.titleC),
                ),
              );
            },
            ),
          )
        );
    },);
  }
}