import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/User.dart';

class UserList extends ChangeNotifier {
  final List<User> _listUsers = [
    User("mariafernandamoura", "mafer1234"),
    User("Andrew Luigi", "gar1234"),
    User("Matheus", "mat1234"),
    User("João B", "jb1234"),
  ];

  List<User> get listUsers => _listUsers;

  void addUser(User u) {
    _listUsers.add(u);
    notifyListeners();
  }
}
