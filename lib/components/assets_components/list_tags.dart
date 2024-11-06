// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/asset_controller.dart';
import 'package:flutter_application_2/controller/tag_asset_controller.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Asset.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:provider/provider.dart';

class ListTagA extends StatefulWidget {
   final ValueChanged<Tag?> onCategorySelected;
  ListTagA({super.key, required this.onCategorySelected});

  @override
  State<ListTagA> createState() => _ListTagAState();
}

class _ListTagAState extends State<ListTagA> {

  TagAssetController _tagAssetController = TagAssetController();
  AssetController _assetController = AssetController();
  
  late List<bool> colorChangeList;
  late List<Tag> categoryList = [];

  @override
  initState(){
    colorChangeList = [];
    loadTags();
    super.initState();
  }

void loadTags() async {
  await _tagAssetController.getTagByUserId(4); // Aguarda a conclusão
  setState(() {
    categoryList = _tagAssetController.tagAssetList; // Atualiza a lista após o carregamento
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