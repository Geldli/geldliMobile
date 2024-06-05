import 'package:flutter/material.dart';

class UserDatas extends ChangeNotifier {
  double totalDespesas = 0;

  late List<Map<String, dynamic>> dados;

  UserDatas() {
    updateTotal(0); // Aqui, passe o valor inicial para o método updateTotal
  }

  void updateTotal(double novoTotalDespesas) {
    totalDespesas = novoTotalDespesas;
    dados = [
      {
        'nome': "Patrimônio",
        'preco': 2222.00,
        'icon': Icon(Icons.attach_money_rounded, size: 30),
      },
      {
        'nome': "Total de Despesas",
        'preco': totalDespesas,
        'icon': Icon(Icons.shopping_bag_rounded, size: 30),
      },
      {
        'nome': "Total de Ativos",
        'preco': 2222.00,
        'icon': Icon(Icons.savings_rounded, size: 30),
      },
    ];
    notifyListeners();
  }
}
