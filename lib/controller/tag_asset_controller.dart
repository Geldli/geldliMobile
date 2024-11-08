import 'dart:convert';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Expense.dart';

class TagAssetController{
  String baseUrl = "http://localhost:3000/api/v1/assetCategory";
  Dio dio = Dio();

  List<Tag> tagAssetList = [];

  // add
Future<String> createAssetTag(Tag tag, int id_user) async {
  var url = '$baseUrl/create';
        final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
        adapter.withCredentials = true;
        dio.httpClientAdapter = adapter;
  try {
    final response = await dio.post(
      url,
      data: jsonEncode(<String, dynamic>{
        'idUser': id_user,
        'color': tag.colorC, 
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


  // getAsset
Future<void> getTagByUserId(int id_user) async {
  var url = '$baseUrl/getByUserId/$id_user';
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      print('Tags recebidas: ${response.data}');
      tagAssetList = (response.data as List)
          .map((tagData) => Tag.fromJson(tagData))
          .toList();
      print('Lista de tags: $tagAssetList');
    } else {
      print('Erro na requisição: ${response.statusCode}');
      tagAssetList = []; 
    }
  } catch (e) {
    print('Erro: $e');
    tagAssetList = []; 
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