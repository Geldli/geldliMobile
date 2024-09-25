import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/Expense.dart';


class toGetId {
  final int id;
  final String title;
  toGetId({required this.id,required this.title});
}

class ExpenseController{
  String baseUrl = "http://localhost:3000/api/v1/expense";
  Dio dio = Dio();

  List<Expense> expenseList = [];

  // add
  Future<String> createExpense(Expense expense, int id_user) async {
    var url = '$baseUrl/create';
    try {
      final response = await dio.post(
        url,
        data: jsonEncode(<String, dynamic>{
        'data': expense.dateToRemember,
        'valor': expense.valueD,
        'name': expense.titleD,
        'description': expense.descriptD,
        'idCategory': expense.category!.titleC,
        'idUser': id_user,
        }),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Despesa criado com sucesso!');
        return 'success';
      } else {
        print('Erro${response.statusCode}');
        return 'error';
      }
    } catch (e) {
      print('Erro: $e');
      return 'error';
    }
  }

  // getExpenses
Future<void> getExpenseByUserId(int id_user) async {
  var url = '$baseUrl/getByUserId/$id_user';
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      // Converta cada item da resposta em uma instância de Expense
      expenseList = (response.data as List)
          .map((expenseData) => Expense.fromJson(expenseData))
          .toList();
    }
  } catch (e) {
    print('Erro: $e');
  }
}


  // delete
Future<void> delete(int id_user, String title) async {
  var url2 = '$baseUrl/getByUserId/$id_user';
  int? id; // Declarado como int? para permitir null

  List<toGetId> idList = [];

  try {
    final response = await dio.get(url2);
    if (response.statusCode == 200) {
      idList = (response.data as List).map((data) {
        return toGetId(
          id: data['id'], // Supondo que 'id' está presente no JSON
          title: data['name'], // Supondo que 'name' está presente no JSON
        );
      }).toList();

      // Procura o id correspondente ao title
      for (var element in idList) {
        if (element.title == title) {
          id = element.id;
          break; // Encerra o loop ao encontrar o id
        }
      }

      if (id == null) {
        print("Título não encontrado.");
        return; // Retorna se o título não foi encontrado
      }
    }
  } catch (e) {
    print('Erro ao obter despesas: $e');
  }

  try {
    var deleteUrl = '$baseUrl/delete/$id'; // Atualiza a URL com o id encontrado
    final deleteResponse = await dio.delete(deleteUrl);
    if (deleteResponse.statusCode == 200) {
      print('Despesa excluída com sucesso.');
    } else {
      print('Erro ao excluir: ${deleteResponse.statusCode}');
    }
  } catch (e) {
    print('Erro ao excluir: $e');
  }
}

  // getByTag
  Future<List<Expense>> getByCategory(int id_user, String category) async {
  var url = '$baseUrl/getByUserAndCategory/$id_user/$category';
  List<Expense> responseData = [];
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      responseData = (response.data as List)
          .map((expenseData) => Expense.fromJson(expenseData))
          .toList();
      print('Despesas filtradas: $responseData');
    }
  } catch (e) {
    print('Erro: $e');
  }
  return responseData;
}


  double totalExpensives(){
    double total = 0;
    for(Expense thisExpensive in expenseList){
        total += thisExpensive.valueD;
      }
      print('despesas: $total');
      return total;
    }
  
}