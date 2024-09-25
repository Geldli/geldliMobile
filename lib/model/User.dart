class User{
String _email = "";
String _username = "";
String _password = "";
String _name = "";
String _surname = "";
 String get name => this._name;

 set name(String value) => this._name = value;

 String get surname => this._surname;

 set surname(String value) => this._surname = value;

 String get email => this._email;

 set email(String value) => this._email = value;

 String get username => this._username;

 set username(String value) => this._username = value;

 String get password => this._password;

set password(String value) => this._password = value;

User(this._username,this._email,this._password , this._name, this._surname);

}