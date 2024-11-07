import 'dart:convert';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/Expense.dart';
import 'package:intl/intl.dart';


class toGetId {
  final int id;
  final String title;
  toGetId({required this.id,required this.title});
}

class ExpenseController{
  String baseUrl = "http://localhost:3000/api/v1/expense";
  Dio dio = Dio();

  List<Expense> expenseList = [];

Future<String> createExpense(Expense expense, int id_user) async {

    var url = '$baseUrl/create';

      String dataString = "06/09/2024";
      DateFormat formatoEntrada = DateFormat("dd/MM/yyyy");
      DateTime data = formatoEntrada.parse(dataString);
      
      DateFormat formatoSaida = DateFormat("yyyy-MM-dd");
      String dataFormatada = formatoSaida.format(data);

    if(expense.dateToRemember == ""){
      dataFormatada = "2024-09-25";
    }
    if(expense.descriptD == ""){
      expense.descriptD = " ";
    }
    print(expense.dateToRemember 
    + expense.titleD + 
    expense.valueD.toString(),
    );

        final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
        adapter.withCredentials = true;
        dio.httpClientAdapter = adapter;
    try {
      
        final response = await dio.post(
            url,
            data: jsonEncode(<String, dynamic>{
                'data': dataFormatada,
                'valor': expense.valueD.toDouble(),
                'name': expense.titleD,
                'description': expense.descriptD,
                'idCategory': expense.category!.titleC,
                'idUser': id_user.toInt(),
            }),
            options: Options(
                headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                },
            ),
        );
        if (response.statusCode == 200) {
            print('Despesa criada com sucesso!');
            return 'success';
        } else {
            print('Erro: ${response.statusCode}, ${response.data}');
            return 'error';
        }
    } catch (e) {
        print('Erro ao criar despesa: $e');
        return 'error';
    }
}


Future<String> edit(Expense expense, int id) async {
  var url = '$baseUrl/update'; 

  String dataString = expense.dateToRemember; 
  DateFormat formatoEntrada = DateFormat("dd/MM/yyyy");
  DateTime data = formatoEntrada.parse(dataString);
  DateFormat formatoSaida = DateFormat("yyyy-MM-dd");
  String dataFormatada = formatoSaida.format(data);

  if (expense.descriptD == "") {
    expense.descriptD = " "; 
  }

  try {
    final response = await dio.put(
      url,
      data: jsonEncode(<String, dynamic>{
        'id': id, //
        'data': dataFormatada,
        'valor': expense.valueD.toDouble(),
        'name': expense.titleD,
        'description': expense.descriptD,
        'idCategory': expense.category!.titleC,
      }),
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Despesa atualizada com sucesso!');
      return 'success';
    } else {
      print('Erro: ${response.statusCode}, ${response.data}');
      return 'error';
    }
  } catch (e) {
    print('Erro ao atualizar despesa: $e');
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
  int? id;

  List<toGetId> idList = [];

  try {
    final response = await dio.get(url2);
    if (response.statusCode == 200) {
      idList = (response.data as List).map((data) {
        return toGetId(
          id: data['id'], // Supondo que 'id' está presente no JSON
          title: data['nome'], // Supondo que 'name' está presente no JSON
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