// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/assets_components/asset_view_assets.dart';
import 'package:flutter_application_2/controller/AssetList.dart';
import 'package:flutter_application_2/model/Asset.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class PanelListA extends StatefulWidget {
  const PanelListA({super.key});
  @override
  State<PanelListA> createState() => _PanelListAState();
}

class _PanelListAState extends State<PanelListA> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AssetList>(builder: (context, value, child) =>
      SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          child: Center(
            child: Column(
              children: [
                Text("Clique no bloco do Ativo para ver detalhes.",style: listViewTitle),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.listAssets.length,
                    itemBuilder: (context, index) {
                      Asset thisAsset = value.listAssets[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: myBlack, 
                          borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),   
                        child: ListTile(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AssetView(thisAsset: thisAsset)
                            ),
                          trailing: Container(
                            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                            decoration: BoxDecoration(
                              color: thisAsset.categoryA!.colorC,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(thisAsset.categoryA!.titleC, style: categoryText),
                          ),
                          title: Text(thisAsset.titleA),
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