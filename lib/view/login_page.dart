// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/inputs.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> registerKey = GlobalKey();
  TextEditingController controllUser = TextEditingController();
  TextEditingController controllPass = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25,horizontal: 30),
        child: Form(
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
                    Input(label: "Email", control: controllUser,itsPass: false),
                    SizedBox(height: 20),
                    Input(label: "Senha", control: controllPass,itsPass: true),
                    SizedBox(height: 20),
                    ElevatedButton(onPressed: () {
                      
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
                    SizedBox(height: 20),
                    TextButton(onPressed: () {
                      
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
    );
  }
}
