// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/controller/AssetList.dart';
import 'package:flutter_application_2/model/Asset.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class AssetView extends StatefulWidget {
  Asset thisAsset;
  AssetView({required this.thisAsset, super.key});

  @override
  State<AssetView> createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AssetList>(builder: (context, value, child) => 
      AlertDialog(
        alignment: AlignmentDirectional.bottomEnd,
        title: Text(widget.thisAsset.titleA),
        titleTextStyle: dialogH1,
        backgroundColor: myBlue,  
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        content: Container(
          height: 105,
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
                      child: Text(widget.thisAsset.descriptA,
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
                      color: widget.thisAsset.categoryA!.colorC,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(widget.thisAsset.categoryA!.titleC, style: categoryText)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Frequência:", style: dialogH2),
                  Text(widget.thisAsset.frequencyA!, style: dialogH3),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Valor em Reais:", style: dialogH2),
                  Text('R\$ ${widget.thisAsset.valueA.toStringAsFixed(2)}', style: dialogH3),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}