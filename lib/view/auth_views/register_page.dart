// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/inputs.dart';
import 'package:flutter_application_2/controller/user_controller.dart';
import 'package:flutter_application_2/model/User.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:flutter_application_2/view/auth_views/login_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> registerKey = GlobalKey();
  TextEditingController controllUser = TextEditingController();
  TextEditingController controllName = TextEditingController();
  TextEditingController controllSurname = TextEditingController();
  TextEditingController controllEmail = TextEditingController();
  TextEditingController controllPass = TextEditingController();
  TextEditingController controllRepass = TextEditingController();

  UserController _userController = UserController();

  void invalidPass(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Suas senhas não combinam.",style: TextStyle(color: myBlack)),
      duration: Durations.short4,
      backgroundColor: myWhite,
      ));
  }

  void sucess(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: TextButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
        child:Text("Prontinho! Agora é só logar",style: TextStyle(color: myBlack))),
      duration: Durations.long1,
      backgroundColor: myWhite,
      ));
  }

  void failed(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Algo deu errado! Tente novamente.",style: TextStyle(color: myBlack)),
      duration: Durations.long1,
      backgroundColor: myWhite,
      ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25,horizontal: 30),
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
                      Text("Ainda não possui uma conta?",style: styleTitle),
                      Text("Então vamos lá...",style: styleTitle)
                    ],
                  ),
                ),
                SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                    SizedBox(
                      width: 250,
                      child: Input(label: "Nome", prefixxIcon: "../assets/images/user.png", itsPass: false, control: controllName),
                    ),
                    SizedBox(
                      width: 180,
                      child: Input(label: "Sobrenome", prefixxIcon: "../assets/images/user.png", itsPass: false, control: controllSurname),
                    )
                  ]),
                  SizedBox(height: 15),
                  Input(label: "Username", prefixxIcon: "../assets/images/user.png", itsPass: false, control: controllUser),
                  SizedBox(height: 15),
                  Input(label: "Email", prefixxIcon: "../assets/images/email.png", itsPass: false, control: controllEmail),
                  SizedBox(height: 15),
                  Input(label: "Senha", prefixxIcon: "../assets/images/pass.png", itsPass: true, control: controllPass),
                  SizedBox(height: 15),
                  Input(label: "Confirme a senha", prefixxIcon: "../assets/images/pass.png", itsPass: true, control: controllRepass),
                  SizedBox(height: 30),

                  //cadastrar botao
                    ElevatedButton(onPressed: () async {
                      if(registerKey.currentState!.validate()){
                        String pass = controllPass.text;
                        String repass = controllRepass.text;
                        if(pass != repass){
                          invalidPass();
                        }else{
                          String username = controllUser.text;
                          String email = controllEmail.text;
                          String name = controllName.text;
                          String surname = controllSurname.text;
                          String password = controllPass.text;
                          User currentUser = User(username, email, password, name, surname);
                          String status = await _userController.createUser(currentUser);
                           if (status == 'success') {
                            sucess(); // Chama a função de sucesso
                          } else {
                            failed(); // Chama a função de falha
                          }
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
                    child: Text("Cadastrar",style: styleHint,)),


                  //ja tenho conta
                    SizedBox(height: 20),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }, child: Align(
                      alignment: Alignment.center,
                      child: Text("Já tenho uma conta!",style: styleLink,)
                    )),
                ],
              ),
            ],
          ),
        )
        ),
      ),
     );
  }
}