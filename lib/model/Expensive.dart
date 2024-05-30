// ignore_for_file: prefer_final_fields, unused_field, avoid_init_to_null

class Expensive{

String _titleD = "";
String _descriptD = "";
DateTime? _dateToRemember = null;
double _valueD = 0.00;

Expensive(this._titleD,this._dateToRemember,this._valueD,this._descriptD);

 String get titleD => this._titleD;

 set titleD(String value) => this._titleD = value;

 String get descriptD => this._descriptD;

 set descriptD(String value) => this._descriptD = value;

 DateTime? get dateToRemember => this._dateToRemember;

 set dateToRemember(DateTime? value) => this._dateToRemember = value;

 double get valueD => this._valueD;

 set valueD(double value) => this._valueD = value;

}