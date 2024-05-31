// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Expensive.dart';

class ExpensiveList extends ChangeNotifier{

  List<Expensive> listExpensives = [];

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