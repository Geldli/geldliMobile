class User{

String _username = "";
String _password = "";

User(this._username,this._password);

String get username => this._username;
set username(String value) => this._username = value;

String get password => this._password;
set password(String value) => this._password = value;

}