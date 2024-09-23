import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Category.dart';

class CategoryList extends ChangeNotifier{
  List<Tag> listCategory = [
    Tag("alimentação", Colors.deepOrangeAccent),
    Tag("alimentação", Colors.deepOrangeAccent),
    Tag("alimentação", Colors.deepOrangeAccent),
    Tag("alimentação", Colors.deepOrangeAccent),
    Tag("alimentação", Colors.deepOrangeAccent),
    Tag("alimentação", Colors.deepOrangeAccent)
  ];

  void addCategory(Tag category){
    listCategory.add(category);
    notifyListeners();
  }
}