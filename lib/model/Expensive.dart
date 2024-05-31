// ignore_for_file: prefer_final_fields, unused_field, avoid_init_to_null

import 'package:flutter/material.dart';

class Expensive{

String _titleD = "";
String _descriptD = "";
String _dateToRemember = "";
String? _frequency = "";
double _valueD = 0.00;
Color? _colorD = null;
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

 Color? get colorD => this._colorD;

 set colorD(Color? value) => this._colorD = value;

Expensive(this._titleD,this._dateToRemember,this._valueD,this._descriptD,this._colorD,this._frequency);



}