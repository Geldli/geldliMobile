// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Expensive.dart';

class ExpensiveList extends ChangeNotifier{

  List<Expensive> listExpensives = [
    Expensive("Plano vivo", "22/02", 20, "plano da maria pois ela gasta pra dedeu", "Mango", Tag("informatica",Colors.amber))  
  ];

  void addExpensive(Expensive expensive){
    listExpensives.add(expensive);
    notifyListeners();
  }

    void mostrar() {
    listExpensives.forEach((Expensive e) {
      print('expensive: \n - ${e.titleD} - \n - ${e.frequency} - \n - ${e.valueD} - \n - ${e.dateToRemember}');
    });
    notifyListeners();
  }

}