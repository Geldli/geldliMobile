import 'dart:convert';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/Asset.dart';
import 'package:intl/intl.dart';


class toGetId {
  final int id;
  final String title;
  toGetId({required this.id,required this.title});
}

class AssetController{
  String baseUrl = "http://localhost:3000/api/v1/asset";
  Dio dio = Dio();

  List<Asset> assetList = [];

Future<String> createAsset(Asset asset, int id_user) async {

    var url = '$baseUrl/create';

  String dataString = asset.dateToRemember;
  
  DateTime data = DateTime.parse(dataString); 
  DateFormat formatoSaida = DateFormat("yyyy-MM-dd");
  String dataFormatada = formatoSaida.format(data);

    if(asset.dateToRemember == ""){
      dataFormatada = "2024-09-25";
    }
    if(asset.descriptD == ""){
      asset.descriptD = " ";
    }
    print(asset.dateToRemember 
    + asset.titleD + 
    asset.valueD.toString(),
    );

        final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
        adapter.withCredentials = true;
        dio.httpClientAdapter = adapter;
    try {
      
        final response = await dio.post(
            url,
            data: jsonEncode(<String, dynamic>{
                'data': '2020/04/04',
                'valor': asset.valueD.toDouble(),
                'name': asset.titleD,
                'description': asset.descriptD,
                'idCategory': asset.category!.titleC,
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

  // getAssets
Future<void> getAssetByUserId(int id_user) async {
  var url = '$baseUrl/getByUserId/$id_user';
  toGetId a;
  List<toGetId> titleToIdList;

  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      assetList = (response.data as List)
          .map((assetData) => Asset.fromJson(assetData))
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
  int id_asset = 0;
  List<toGetId> titleToIdList = [];
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      titleToIdList = (response.data as List)
          .map((assetData) => toGetId(
                id: assetData['id'],    // Pegando o id da resposta
                title: assetData['nome'], // Pegando o nome (title) da resposta
              ))
          .toList();
          
        }
      for (var element in titleToIdList) {
        if(element.title == title){
          id_asset = element.id;
          print("o ID EH:" + element.id.toString());
        }
      }
  } catch (e) {
    print('Erro: $e');
  }

  return id_asset;
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

      for (var element in idList) {
        if (element.title == title) {
          id = element.id;
          break;
        }
      }

      if (id == null) {
        print("Título não encontrado.");
        return;
      }
    }
  } catch (e) {
    print('Erro ao obter despesas: $e');
  }

  try {
    var deleteUrl = '$baseUrl/delete/$id';
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
  Future<List<Asset>> getByCategory(int id_user, String category) async {
  var url = '$baseUrl/getByUserAndCategory/$id_user/$category';
  List<Asset> responseData = [];
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      responseData = (response.data as List)
          .map((assetData) => Asset.fromJson(assetData))
          .toList();
      print('Despesas filtradas: $responseData');
    }
  } catch (e) {
    print('Erro: $e');
  }
  return responseData;
}


  double totalAsset(){
    double total = 0;
    for(Asset thisExpensive in assetList){
        total += thisExpensive.valueD;
      }
      print('assets: $total');
      return total;
    }
  



Future<String> edit(Asset asset, String nome) async {
  var url = '$baseUrl/update';

  String dataString = asset.dateToRemember;
  
  DateTime data = DateTime.parse(dataString); 
  DateFormat formatoSaida = DateFormat("yyyy-MM-dd");
  String dataFormatada = formatoSaida.format(data);

  if (asset.dateToRemember == "") {
    dataFormatada = "2024-09-25";
  }
  if (asset.descriptD == "") {
    asset.descriptD = " "; 
  }

  print(asset.dateToRemember +
      asset.titleD +
      asset.valueD.toString(),
  );

  final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
  adapter.withCredentials = true;
  dio.httpClientAdapter = adapter;
  int id;
  id = await getId(3, nome);
  try {
    print("idas" + id.toString());
    final response = await dio.put(
      url,
      data: jsonEncode(<String, dynamic>{
        'id': id,
        'data': dataFormatada,
        'valor': asset.valueD.toDouble(),
        'name': asset.titleD,
        'description': asset.descriptD,
        'idCategory': asset.category!.titleC,
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