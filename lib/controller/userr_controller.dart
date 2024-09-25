import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;


class UserrController {
  String baseUrl = "http://localhost:3000/api/v1/user";
  Dio dio = Dio();

Future<String> createUser(User user) async {
    var url = '$baseUrl/create';
    try {
      final response = await dio.post(
        url,
        data: jsonEncode(<String, dynamic>{
          'email': user.email,
          'username': user.username,
          'password': user.password,
          'name': user.name,
          'surname': user.surname,
        }),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // Adicione o token se necessário
            'Authorization': 'Bearer ${html.window.localStorage['authToken']}', 
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Usuário criado com sucesso!');
        return 'success'; // Retorna 'success' se tudo der certo
      } else {
        print('Erro ao criar usuário: ${response.statusCode}');
        return 'error'; // Retorna 'error' em caso de erro
      }
    } catch (e) {
      print('Erro: $e');
      return 'error'; // Retorna 'error' em caso de exceção
    }
  }


}
