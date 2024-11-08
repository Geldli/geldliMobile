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

      String dataString = expense.dateToRemember;
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

  // getExpenses
Future<void> getExpenseByUserId(int id_user) async {
  var url = '$baseUrl/getByUserId/$id_user';
  toGetId a;
  List<toGetId> titleToIdList;

  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      expenseList = (response.data as List)
          .map((expenseData) => Expense.fromJson(expenseData))
          .toList();
        }
  } catch (e) {
    print('Erro: $e');
  }
}

  // getIdByTitle
Future<int> getId(int id_user, String title) async {
  var url = '$baseUrl/getByUserId/$id_user';
  toGetId a;
  int id_expense = 0;
  List<toGetId> titleToIdList = [];
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      titleToIdList = (response.data as List)
          .map((expenseData) => toGetId(
                id: expenseData['id'],    // Pegando o id da resposta
                title: expenseData['nome'], // Pegando o nome (title) da resposta
              ))
          .toList();
          
        }
      for (var element in titleToIdList) {
        if(element.title == title){
          id_expense = element.id;
          print("o ID EH:" + element.id.toString());
        }
      }
  } catch (e) {
    print('Erro: $e');
  }

  return id_expense;
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
          id: data['id'], 
          title: data['nome'], 
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
  



Future<String> edit(Expense expense, String nome) async {
  var url = '$baseUrl/update';

  String dataString = expense.dateToRemember;
  
  DateTime data = DateTime.parse(dataString); // Aqui usamos DateTime.parse() diretamente
  DateFormat formatoSaida = DateFormat("yyyy-MM-dd");
  String dataFormatada = formatoSaida.format(data);

  if (expense.dateToRemember == "") {
    dataFormatada = "2024-09-25"; // Fallback para uma data padrão caso a data esteja vazia
  }
  if (expense.descriptD == "") {
    expense.descriptD = " "; // Se a descrição estiver vazia, atribui um valor padrão
  }

  print(expense.dateToRemember +
      expense.titleD +
      expense.valueD.toString(),
  );

  final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
  adapter.withCredentials = true;
  dio.httpClientAdapter = adapter;
  int id;
  id = await getId(3, nome);
  print('ID: ${id}');  // You can replace 44 with the correct ID later
  print('Data: $dataFormatada');
  print('Valor: ${expense.valueD.toDouble()}');
  print('Name: ${expense.titleD}');
  print('Description: ${expense.descriptD}');
  print('Category ID: ${expense.category!.titleC}');
    try {
    print("idas" + id.toString());
    final response = await dio.put(
      url,
      data: jsonEncode(<String, dynamic>{
        'id': id, // Aqui você pode substituir pelo ID correto, se necessário
        'data': dataFormatada,
        'valor': expense.valueD.toDouble(),
        'name': expense.titleD, // Substitua pelo nome correto
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
      print('Despesa alterada com sucesso!');
      return 'success';
    } else {
      print('Erro: ${response.statusCode}, ${response.data}');
      return 'error';
    }
  } catch (e) {
    print('Erro ao alterar despesa: $e');
    return 'error';
  }
}



}