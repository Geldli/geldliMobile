// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/inputs.dart';
import 'package:flutter_application_2/model/User.dart';
import 'package:flutter_application_2/model/UserList.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:flutter_application_2/view/home_page.dart';
import 'package:flutter_application_2/view/register_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> registerKey = GlobalKey();
  TextEditingController controllUser = TextEditingController();
  TextEditingController controllPass = TextEditingController();
  bool isRegister = false;
  void compare(User user){
    UserList().listUsers.forEach((User u) { 
      if(u.username == user.username && u.password == user.password){
        isRegister=true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: Form(
          key: registerKey,
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
                    suffixText: "@gmail.com",
                    prefixxIcon: "../assets/images/email.png",
                    control: controllUser,
                    itsPass: false),
                    SizedBox(height: 20),

                    Input(label: "Senha", 
                    suffixText: "" ,
                    prefixxIcon: "../assets/images/pass.png",
                    control: controllPass,
                    itsPass: true),
                    SizedBox(height: 5),
                    TextButton(onPressed: () {
                      
                    }, 
                    
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Esqueci minha senha :(",style: styleLink2)),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(onPressed: () {
                      if(registerKey.currentState!.validate()){
                        User userData = User(controllUser.text,controllPass.text);
                        compare(userData);
                        if(isRegister){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }
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
    );
  }
}
