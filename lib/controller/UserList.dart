
// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/ExpensiveList.dart';
import 'package:flutter_application_2/model/Expensive.dart';

import 'package:flutter_application_2/model/User.dart';

class UserList extends ChangeNotifier {

  List<User> listUsers = [];

  void mostrar() {
    listUsers.forEach((User u) {
      print('user: \n - ${u.username} - \n - ${u.email} - \n - ${u.idUser} - \n - ${u.password}');
    });
    notifyListeners();
  }

  bool userExists(String email, String password) {
    return listUsers.any((user) => user.email == email && user.password == password);
  }

  void addUser(User u) {
    listUsers.add(u);
    notifyListeners();
  }

  void deleteUser(String email) {
    listUsers.removeWhere((User user) => user.email == email);
    notifyListeners();
  }

  String? findUserNameByEmail(String email){
    for(User user in listUsers){
      if(user.email == email){
        return user.username;
      }
    }
    return null;
  }

}


