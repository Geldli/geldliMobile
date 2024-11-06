// ignore_for_file: prefer_final_fields, unused_field, avoid_init_to_null

import 'package:flutter_application_2/model/Category.dart';

class Asset{

String _titleD = "";
String _descriptD = "";
String _dateToRemember = "";
String? _frequency = "";
double _valueD = 0.00;
Tag? _category = null;

 Tag? get category => this._category;

 set category(Tag? value) => this._category = value;
 String get titleD => this._titleD;

 set titleD(String value) => this._titleD = value;

 String get descriptD => this._descriptD;

 set descriptD(String value) => this._descriptD = value;

 String get dateToRemember => this._dateToRemember;

 set dateToRemember(String value) => this._dateToRemember = value;

 String? get frequency => this._frequency;

 set frequency(String? value) => this._frequency = value;

 double get valueD => this._valueD;

 set valueD(double value) => this._valueD = value;

Asset(this._titleD,this._dateToRemember,this._valueD,this._descriptD,this._frequency,this._category);

  // Método para converter um Map em uma instância de Expense
factory Asset.fromJson(Map<String, dynamic> json) {
  return Asset(
    json['nome'] ?? '', // Título da despesa
    json['data'] ?? '', // Data da despesa
    json['valor'].toDouble(), // Valor da despesa
    json['descricao'] ?? '', // Descrição da despesa
    json['frequencia'] ?? '', // Frequência (pode ser null)
    Tag.fromString(json['idCategoria'] ?? ''), // Cria a Tag a partir do nome da categoria
  );
}



}