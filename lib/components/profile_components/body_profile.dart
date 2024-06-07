// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/components/profile_components/buttom_body_profile.dart';
import 'package:flutter_application_2/components/profile_components/inputs_profile.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
    TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 130, 25, 10),
        color: myBlack,
        child: Column(
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // email input
                  Row(
                    children: [
                      Text("  Endereço de email",style: profileH3),
                      IconButton(onPressed: (){}, 
                      icon: Icon(Icons.edit, color: myWhite, size: 15)
                      )
                    ],
                  ),
                  SizedBox(height: 3),
                  InputProfile(itsPass: false, control: text),
                  
                  // pass input
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("  Senha",style: profileH3),
                      IconButton(onPressed: (){}, 
                      icon: Icon(Icons.edit, color: myWhite, size: 15)
                      )
                    ],
                  ),
                  SizedBox(height: 2),
                  InputProfile(itsPass: true, control: text),
                  SizedBox(height: 20),
                  //save buttom
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ButtomBodyProfile(
                      label: "  Salvar Alterações", 
                      icon: Icon(Icons.save_as_sharp, color: Color.fromRGBO(77, 156, 114, 1)), 
                      style: buttomSave,
                      align: MainAxisAlignment.end,
                      ),
                      
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}