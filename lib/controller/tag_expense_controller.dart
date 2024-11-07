import 'dart:convert';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Expense.dart';

class TagExpenseController{
  String baseUrl = "http://localhost:3000/api/v1/expenseCategory";
  Dio dio = Dio();

  List<Tag> tagExpenseList = [];

  // add
Future<String> createExpenseTag(Tag tag, int id_user) async {
  var url = '$baseUrl/create';
          final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
        adapter.withCredentials = true;
        dio.httpClientAdapter = adapter;
  try {
    final response = await dio.post(
      url,
      data: jsonEncode(<String, dynamic>{
        'idUser': id_user.toInt(),
        'color': tag.colorC, // Mantenha como string
        'name': tag.titleC,
      }),
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Tag criada com sucesso!');
      return 'success';
    } else {
      print('Erro ${response.statusCode}');
      return 'error';
    }
  } catch (e) {
    print('Erro: $e');
    return 'error';
  }
}


  // getExpenses
Future<void> getTagByUserId(int id_user) async {
  var url = '$baseUrl/getByUserId/$id_user';
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      print('Tags recebidas: ${response.data}');
      tagExpenseList = (response.data as List)
          .map((tagData) => Tag.fromJson(tagData))
          .toList();
      print('Lista de tags: $tagExpenseList');
    } else {
      print('Erro na requisição: ${response.statusCode}');
      tagExpenseList = []; // Certifique-se de limpar a lista em caso de erro
    }
  } catch (e) {
    print('Erro: $e');
    tagExpenseList = []; // Limpe a lista em caso de exceção
  }
}


  // delete
  Future<void> delete(int id_user, int id) async {
    var url = '$baseUrl/delete/${id}';
    try {
      final response = await dio.delete(url);
      getTagByUserId(id_user);
      } catch (e) {
        print('Erro: $e');
      }
  }

}