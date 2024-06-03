// ignore_for_file: avoid_init_to_null, prefer_final_fields, unused_field

import 'package:flutter/material.dart';

class Tag{
  String _titleC = "";
  Color? _colorC = null;
  Tag(this._titleC,this._colorC);
  get titleC => this._titleC;
  set titleC( value) => this._titleC = value;
  get colorC => this._colorC;
  set colorC( value) => this._colorC = value;
}