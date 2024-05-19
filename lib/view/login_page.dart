// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/inputs.dart';
import 'package:flutter_application_2/model/User.dart';
import 'package:flutter_application_2/model/UserList.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> registerKey = GlobalKey();
  TextEditingController controllUser = TextEditingController();
  TextEditingController controllPass = TextEditingController();

  void registerUser(User u) {
    Provider.of<UserList>(context, listen: false).addUser(u);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Form(
            key: registerKey,
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("AINDA NÃO POSSUI UMA CONTA?",style: styleH1),
                      TextButton(onPressed: () {
                        
                      }, child: Text("cadastre-se",style: styleH2))
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child:Text("Login",style:styleBigText),
                  ),
                  SizedBox(height: 25,),
                  Input(control: controllUser, label: "Usuário"),
                  SizedBox(height: 20),
                  Input(control: controllPass, label: "Senha"),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text.rich(TextSpan(text: "Esqueceu sua senha?",style: styleSpan)),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(240, 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        backgroundColor: myDarkY,

                      ),
                      onPressed: () {
                        if (registerKey.currentState!.validate()) {
                          registerUser(
                              User(controllUser.text, controllPass.text));
                        }
                      },
                      child: Text("Entrar")),
                      SizedBox(height: 10),
                      Text("ou",style: styleH1,),
                      SizedBox(height: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: myWhite,width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          fixedSize: Size(240, 25)
                        ),
                        onPressed: () {
                        
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Entre com o Google",style: styleH1,),
                      ],))
                ],
              ),
            )),
      ),
    );
  }
}
