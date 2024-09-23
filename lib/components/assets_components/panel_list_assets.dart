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

  void deleteAsset(Asset asset){
    //Provider.of<AssetList>(context, listen: false).removeAsset(asset);
  }

  @override
  Widget build(BuildContext context) {
        return Consumer<AssetList>(builder: (context, value, child) =>
      SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          child: Center(
            child: Column(
              children: [
                AssetList().listAssets.isNotEmpty ?
                Text("Clique no bloco da despesa para ver detalhes.",style: listViewTitle):
                Text("Aqui você poderá controlar suas despesas depois forem criadas.",style: listViewTitle),
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
                          leading: PopupMenuButton(
                            iconColor: myWhite,
                            color: myWhite,
                            onSelected: (value) {
                              if(value == "delete"){
                                deleteAsset(thisAsset);
                              }  
                            },
                            itemBuilder: (BuildContext context){
                              return const [
                                PopupMenuItem(
                                  child: Text("Excluir"),
                                  value: 'delete',
                                  height: 35,
                                )
                              ];
                            }
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