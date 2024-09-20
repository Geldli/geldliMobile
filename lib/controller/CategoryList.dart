import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Category.dart';

class CategoryList extends ChangeNotifier{
  List<Tag> listCategory = [
    Tag("teste", Colors.amber),
    Tag("tste2", Colors.red)
  ];

  void addCategory(Tag category){
    listCategory.add(category);
    notifyListeners();
  }
}