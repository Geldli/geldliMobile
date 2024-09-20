// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Asset.dart';
import 'package:flutter_application_2/model/Category.dart';

  class AssetList extends ChangeNotifier{

    List<Asset> listAssets = [
      Asset("s", "_descriptA", Tag('d', Colors.black), "_frequencyA", "", 500)
    ];

    void addAsset(Asset asset){
      listAssets.add(asset);
      notifyListeners();
    }

    void mostrar() {
    listAssets.forEach((Asset a) {
      print('Ativo: \n - ${a.titleA} - \n - ${a.frequencyA} - \n - ${a.valueA} - \n - ${a.dateToRememberA}');
    });
    notifyListeners();
    }

    double totalAssets(){
      double total = 0;
      for(Asset thisAsset in listAssets){
        total += thisAsset.valueA;
      }
      print('Ativos: $total');
      notifyListeners();
      return total;
    }

  }