// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/inputs.dart';
import 'package:flutter_application_2/controller/UserList.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:flutter_application_2/view/controll_page.dart';
import 'package:flutter_application_2/view/auth_views/register_page.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginKey = GlobalKey();
  TextEditingController controllEmail = TextEditingController();
  TextEditingController controllPass = TextEditingController();

  String hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
  }

  void invalidLogin(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Email ou Senha Inválidos. Tente novamente!",style: TextStyle(color: myBlack)),
      duration: Durations.short4,
      backgroundColor: myWhite,
      ));
  }

  void verify(String email, String pass) {
    bool userExists = Provider.of<UserList>(context, listen: false).userExists(email, pass);
    if (userExists) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ControllPage(email: controllEmail.text)));
    } else {
    invalidLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserList>(builder: (context, value, child) => Scaffold(
      backgroundColor: myBlack,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: Form(
          key: loginKey,
          child: Center(
            child: Column(   
              mainAxisAlignment: MainAxisAlignment.spaceAround,           
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Já possui uma conta?",style: styleTitle),
                      Text("Então vamos lá...",style: styleTitle)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [

                    Input(label: "Email", 
                    prefixxIcon: "../assets/images/email.png",
                    control: controllEmail,
                    itsPass: false),
                    SizedBox(height: 20),

                    Input(label: "Senha", 
                    prefixxIcon: "../assets/images/pass.png",
                    control: controllPass,
                    itsPass: true),
                    SizedBox(height: 5),

                    //esqueci minha senha
                    TextButton(onPressed: () {
                      
                    }, 
                    
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Esqueci minha senha :(",style: styleLink2)),
                    ),
                    SizedBox(height: 20),

                    //login botao

                    ElevatedButton(onPressed: () {
                      if(loginKey.currentState!.validate()){
                        String email = controllEmail.text;
                        String pass = hashPassword(controllPass.text);
                        verify(email,pass);
                      }
                      setState(() {
                        
                      });
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myDarkY,
                      elevation: 0,
                      fixedSize: Size.fromWidth(double.maxFinite),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      )
                    ),
                    child: Text("Entrar",style: styleHint,)),

                    // nao tenho conta
                    SizedBox(height: 20),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                    }, child: Align(
                      alignment: Alignment.center,
                      child: Text("Ainda não tenho uma conta!",style: styleLink,)
                    )),
                  ],
                )
              ],
            ),
          ),),  
      ),
    ),);
  }
}
