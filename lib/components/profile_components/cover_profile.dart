// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/profile_components/buttom_body_profile.dart';
import 'package:flutter_application_2/model/User.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class CoverProfile extends StatefulWidget {
  String? email;
  String? name;
  CoverProfile({
    required this.email,
    required this.name,
    super.key});

  @override
  State<CoverProfile> createState() => _CoverProfileState();
}

class _CoverProfileState extends State<CoverProfile> {
  var selectItem = "";

  void deleteUser(User user){
    //Provider.of<UserList>(context,listen: false).deleteUser(widget.email);
  }

  void confirmDelete(){
    showDialog(
      context: context, 
      builder: (BuildContext contextx){
        return AlertDialog(
          backgroundColor: myWhite,
          title: Text("Tem certeza disso?", style: titleDialog),
          titlePadding: EdgeInsets.fromLTRB(30, 30, 0, 10),
          contentPadding: EdgeInsets.fromLTRB(35, 10, 20, 10),
          content: Container(
            height: 120,
            width: 80,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Esta ação é irreversível e você perderá todos os dados associados à sua conta.", maxLines: 3),
                  Align(alignment: Alignment.bottomLeft, child: ButtomBodyProfile(label: "Excluir conta", icon: Icon(Icons.delete,color:  Color.fromRGBO(242, 74, 74, 1)), style: buttomDelete,align: MainAxisAlignment.start,))
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("..//../../assets/images/cover_profile.png"),
        fit: BoxFit.cover)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: myWhite
          ),          
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton(
              iconColor: myWhite,
              color: myWhite,
              onSelected: (value) {
                setState(() {
                  selectItem = value.toString();
                });
                if(selectItem == 'relatorio'){
                    
                }else if(selectItem == 'deleteAcount'){
                  confirmDelete();
                }
              },
              itemBuilder: (BuildContext context){
                return const [
                  PopupMenuItem(
                    child: Text("Gerar Relatórios"),
                    value: 'relatorio',
                  ),
                  PopupMenuItem(
                    child: Text("Excluir Conta"),
                    value: 'deleteAcount',
                  )
                ];
              }
              )
          ],
        ),
      ),
    );
  }
}