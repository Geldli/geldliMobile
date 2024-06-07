import 'package:flutter/material.dart';

class UserDatas extends ChangeNotifier {

   List<Map<String, dynamic>> dados = [
      {
        'nome': "Patrimônio",
        'preco': 00.00,
        'icon': Icon(Icons.attach_money_rounded, size: 30),
      },  
      {
        'nome': "Total de Despesas",
        'preco': 00.00,
        'icon': Icon(Icons.shopping_bag_rounded, size: 30),
      },
      {
        'nome': "Total de Ativos",
        'preco': 00.00,
        'icon': Icon(Icons.savings_rounded, size: 30),
      },
   ];

}
