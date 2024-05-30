// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UserDatas extends ChangeNotifier{

    List<Map<String,dynamic>> dados = [
    {
      'nome': "Patrimônio",
      'preco': 2222.00,
      'icon': Icon(Icons.attach_money_rounded,size: 30),
    },
    {
      'nome': "Total de Despesas",
      'preco': 2222.00,
      'icon': Icon(Icons.shopping_bag_rounded,size: 30),
    },
    {
      'nome': "Total de Ativos",
      'preco': 2222.00,
      'icon': Icon(Icons.star_rate_rounded,size: 30),
    },
  ];
}