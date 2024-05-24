// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/inputs.dart';
import 'package:flutter_application_2/ui/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllUser = TextEditingController();
  TextEditingController controllEmail = TextEditingController();
  TextEditingController controllPass = TextEditingController();
  TextEditingController controllRepass = TextEditingController();

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
              Column(
                children: [
                  Input(label: "Usuário", suffixText: "", prefixxIcon: "../assets/images/user.png", itsPass: false, control: controllUser),
                  SizedBox(height: 15),
                  Input(label: "Email", suffixText: "@gmail.com", prefixxIcon: "../assets/images/email.png", itsPass: false, control: controllEmail),
                  SizedBox(height: 15),
                  Input(label: "Senha", suffixText: "", prefixxIcon: "../assets/images/pass.png", itsPass: true, control: controllPass),
                  SizedBox(height: 15),
                  Input(label: "Confirme a senha", suffixText: "", prefixxIcon: "../assets/images/pass.png", itsPass: true, control: controllRepass),
                  SizedBox(height: 15),
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