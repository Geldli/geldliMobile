class User{
String _idUser = "";
String _email = "";
String _username = "";
String _password = "";
 String get idUser => this._idUser;

 set idUser(String value) => this._idUser = value;

 String get email => this._email;

 set email(String value) => this._email = value;

 String get username => this._username;

 set username(String value) => this._username = value;

 String get password => this._password;

set password(String value) => this._password = value;
User(this._idUser,this._username,this._email,this._password);

}