// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, unused_field, unused_local_variable, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/controller/AssetList.dart';
import 'package:flutter_application_2/model/Asset.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class FormNewA extends StatefulWidget {
  const FormNewA({super.key});

  @override
  State<FormNewA> createState() => _FormNewAState();
}

class _FormNewAState extends State<FormNewA> {
  GlobalKey<FormState> chave = GlobalKey();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerValue = TextEditingController();
  TextEditingController controllerTag = TextEditingController();
  String? _controllerFrequency;

  void addNew(Asset asset){
    Provider.of<AssetList>(context,listen: false).addAsset(asset);
    Provider.of<AssetList>(context,listen: false).mostrar();
  }

  void sucess(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Ativo criado!",style: TextStyle(color: myBlack)),
      duration: Durations.long2,
      backgroundColor: myDarkY,
      ));
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AssetList>(builder: (context, value, child) =>
      Container(
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromRGBO(245,245,245,0.8),
              Color.fromRGBO(226,231,237,0.6),
            ]
              )
            ),
          child: ElevatedButton(onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: myDarkY,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              title: Text("Novo Ativo"),
              titleTextStyle: formHeader,
              content: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: myBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7))
                ),
                height: 400,
                width: 400,
                child: Form(
                  key: chave,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
      
                        //TITLE input
                        TextFormField(
                          controller: controllerTitle,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myDarkY, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Título",
                            hintStyle: hintForm,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            isCollapsed: true,
                            filled: true,
                            fillColor: myBlack,
                            errorStyle: errorStyle,
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myDarkY),
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Por favor escolha um título!";
                            }
                            return null;
                          },
                          style: formTextStyle,
                        ),
      
                        SizedBox(height: 10),
                        //DESCRIPTION
                        TextFormField(
                          controller: controllerDesc,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myDarkY, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Descrição",
                            hintStyle: hintForm,
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            isCollapsed: true,
                            filled: true,
                            fillColor: myBlack
                          ),
                          maxLines: 3,
                          style: formTextStyle,  
                        ),
      
      
                        SizedBox(height: 10),
                        //CATEGORIA input provisorio
                        TextFormField(
                          controller: controllerTag,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myDarkY, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Categoria",
                            hintStyle: hintForm,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            isCollapsed: true,
                            filled: true,
                            fillColor: myBlack,
                            errorStyle: errorStyle,
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myDarkY),
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Por favor escolha um título!";
                            }
                            return null;
                          },
                          style: formTextStyle,
                        ),
      
                        SizedBox(height: 10),

                        //DATE input
                        TextFormField(
                          controller: controllerDate,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myDarkY, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Data",
                            hintStyle: hintForm,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            isCollapsed: true,
                            filled: true,
                            fillColor: myBlack
                          ),
                          style: formTextStyle,
                        ),
      
                        SizedBox(height: 10),
      
                        //FREQUENCIA input
                        DropdownButtonFormField<String>(
                          dropdownColor: myDarkY,
                          elevation: 0,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            filled: true,
                            fillColor: myBlack,
                            isCollapsed: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myDarkY, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),                          
                          ),
                          hint: Text('Frequência', style: hintForm,),
                          value: _controllerFrequency,
                          onChanged: (String? newValue) {
                            setState(() {
                              _controllerFrequency = newValue!;
                            });
                          },
                          items: <String>['Apple', 'Mango', 'Banana', 'Peach']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: formTextStyle),
                            );
                          }).toList()
                        ),
      
                        SizedBox(height: 10),
      
                        //VALUE and Tag
                        TextFormField(
                          controller: controllerValue,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myDarkY, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Valor",
                            hintStyle: hintForm,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            isCollapsed: true,
                            filled: true,
                            fillColor: myBlack
                          ),
                          style: formTextStyle,
                        ),
                        
                        SizedBox(height: 10),
                        //CATEGORIA   INPUT
      
                        SizedBox(height: 10),
                        //BUTTOM ROW
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(onPressed: (){
                              if(chave.currentState!.validate()){
                                String? frequencia = _controllerFrequency;
                                String titulo = controllerTitle.text;
                                String data = controllerDate.text;
                                double valor = double.parse(controllerValue.text);
                                String descricao = controllerDesc.text;
                                int i = Random().nextInt(7);
                                Color colorC = colorsForChoice[i];
                                String titleC = controllerTag.text;
                                Tag categoria = Tag(titleC , colorC);
                                Asset assetCreating = Asset(titulo, descricao, categoria, frequencia, data, valor);
                                addNew(assetCreating);
                                Navigator.pop(context);
                                sucess();
                            }},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: myDarkY
                            ),
                            child: Text("CRIAR"))
                          ],
                        )                   
                      ],
                    ),
                  )
                  ),
              ),
            )
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent,
            shadowColor: Colors.transparent 
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("ADICIONAR ",style: buttomText),
            Icon(Icons.add_rounded,color: myBlue,weight: 6),
        ],
      ))),
    );
  }
}