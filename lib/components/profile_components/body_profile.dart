import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/inputs_profile.dart';
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
        padding: EdgeInsets.fromLTRB(25, 100, 25, 10),
        color: myBlack,
        child: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Text("Informações da conta",style: profileH2),
                    Column(
                      children: [
                        Align(alignment:Alignment.bottomLeft ,child: Text("Endereço de email",style: profileH3)),
                        InputProfile(itsPass: false, control: text),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Senha",style: profileH3),
                            Text("Alterar Senha",style: profileH3)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    ElevatedButton(onPressed: () {
                      
                    }, 
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(250),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      foregroundColor: Colors.transparent,
                    ),                            
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.save_rounded,color: Color.fromRGBO(77, 156, 114, 1),),
                        Text("  Salvar Alterações",style: buttomSave,)
                      ],
                    )),
                
                    ElevatedButton(onPressed: () {
                      
                    }, 
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(250),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      foregroundColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.delete,color: Color.fromRGBO(242, 74, 74, 1),),
                        Text("  Excluir Conta",style: buttomDelete)
                      ],
                    ))
                  ],
                ),
              )
            ],
          )
        ),
      )
    );
  }
}