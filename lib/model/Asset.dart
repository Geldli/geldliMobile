// ignore_for_file: prefer_final_fields, unused_field, avoid_init_to_null, unnecessary_this

import 'package:flutter_application_2/model/Category.dart';

class Asset{

  String _titleA = "";
  String _descriptA = "";
  String _dateToRememberA = "";
  String? _frequencyA = "";
  double _valueA = 0.00;
  Tag? _categoryA = null;

  Asset(this._titleA,this._descriptA,this._categoryA,this._frequencyA,this._dateToRememberA,this._valueA);

  String get titleA => this._titleA;
  set titleA(String value) => this._titleA = value;

  String get descriptA => this._descriptA;
  set descriptA(String value) => this._descriptA = value;

  String get dateToRememberA => this._dateToRememberA;
  set dateToRememberA(String value) => this._dateToRememberA = value;

  String? get frequencyA => this._frequencyA;
  set frequencyA(String? value) => this._frequencyA = value;

  double get valueA => this._valueA;
  set valueA(double value) => this._valueA = value;

  Tag? get categoryA => this._categoryA;
  set categoryA(Tag? value) => this._categoryA = value;

}