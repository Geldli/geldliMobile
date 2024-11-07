import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/browser.dart';
import 'package:flutter_application_2/model/User.dart';
import 'dart:html';


class UserDetails {
  final String id;
  final String nome;
  final String email;

  UserDetails({required this.id, required this.nome, required this.email});
}

class UserController {
  String baseUrl = "http://localhost:3000/api/v1/user";
  Dio dio = Dio();

  Future<String> createUser(User user) async {
    final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

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
            'Access-Control-Allow-Credentials': 'true',
            // 'Authorization': 'Bearer ${html.window.localStorage['authToken']}', 
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Usuário criado com sucesso!');
        return 'success';
      } else {
        print('Erro ao criar usuário: ${response.statusCode}');
        return 'error';
      }
    } catch (e) {
      print('Erro: $e');
      return 'error';
    }
  }

Future<UserDetails?> login(String login, String pass) async {
  final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
  adapter.withCredentials = true;
  dio.httpClientAdapter = adapter;
  print("login");
  var url = '$baseUrl/login';
  try {
    final response = await dio.post(
      url,
      data: jsonEncode(<String, dynamic>{
        'login': login,
        'password': pass,
      }),
      options: Options(
        headers: <String, String>{
          // 'Authorization': 'Bearer ${html.window.localStorage['authToken']}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );

    var responseData = response.data;
    var control = responseData['loginSuccessful'];

    print(response.statusCode);
    print(responseData['loginSuccessful']);
    print(control);

    testCookie();


    if (response.statusCode == 200 && control == true) {
      // Se o login for bem-sucedido, chama o método para obter os detalhes do usuário
      return await getUserByLogin(login);
    } else {
      return null; // Retorna null em caso de falha no login
    }
  } catch (e) {
    print('Erro: $e');
    return null; // Retorna null em caso de exceção
  }
}

Future<UserDetails?> testCookie() async {
  final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
  adapter.withCredentials = true;
  dio.httpClientAdapter = adapter;

  var url = '$baseUrl/getUserData';
  try {
    final response = await dio.post(url);

    print(response);
  } catch (e) {
    print('Erro: $e');
    return null; // Retorna null em caso de exceção
  }

}

Future<UserDetails?> getUserByLogin(String login) async {

  final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
  adapter.withCredentials = true;
  dio.httpClientAdapter = adapter;

  var url = '$baseUrl/getAll';
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      List<dynamic> users = response.data;
      for (var user in users) {
        if (user['username'] == login || user['email'] == login) {
          return UserDetails(
            id: user['id'].toString(),
            nome: user['nome'],
            email: user['email'],
          ); // Retorna os detalhes do usuário
        }
      }
      return null; // Retorna null se não encontrar o usuário
    } else {
      return null; // Retorna null em caso de erro
    }
  } catch (e) {
    print('Erro ao obter usuários: $e');
    return null; // Retorna null em caso de exceção
  }
}
}
