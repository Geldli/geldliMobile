import 'dart:convert';
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

  // 
Future<String> createAsset(Asset asset, int id_user) async {
    var url = '$baseUrl/create';

          String dataString = "06/09/2024";
  DateFormat formatoEntrada = DateFormat("dd/MM/yyyy");
  DateTime data = formatoEntrada.parse(dataString);
  
  DateFormat formatoSaida = DateFormat("yyyy-MM-dd");
  String dataFormatada = formatoSaida.format(data);
  
    if(asset.dateToRemember == ""){
      asset.dateToRemember = "2024-09-25";
    }
        if(asset.descriptD == ""){
      asset.descriptD = " ";
    }
    try {
        final response = await dio.post(
            url,
            data: jsonEncode(<String, dynamic>{
                'data': dataFormatada,
                'valor': asset.valueD,
                'name': asset.titleD,
                'description': asset.descriptD,
                'idCategory': asset.category!.titleC,
                'idUser': id_user,
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
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      // Converta cada item da resposta em uma instância de Asset
      assetList = (response.data as List)
          .map((assetData) => Asset.fromJson(assetData))
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
    for(Asset thisAsset in assetList){
        total += thisAsset.valueD;
      }
      print('asset: $total');
      return total;
    }
  
}