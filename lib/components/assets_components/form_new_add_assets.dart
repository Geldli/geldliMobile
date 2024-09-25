// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, unused_field, unused_local_variable, must_be_immutable

import 'dart:math';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/controller/AssetList.dart';
import 'package:flutter_application_2/model/Asset.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:intl/intl.dart';
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

  DateTime? selectedDate;
  final dateFormat = DateFormat('dd/MM/yyyy'); // Formato da data

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(primary: myDarkY),
          dialogBackgroundColor: myWhite
        ),
        child: child ?? Container());
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controllerDate.text = dateFormat.format(selectedDate!);
      });
    }
  }
  
  DateTime? data;
  String? _controllerFrequency;
  List<String> frequencyItems = ["1","2","3"];
  final TextEditingController _dropdownSearchFieldController = TextEditingController();
  String? _selectedFruit;
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  List<Tag> categoryList =  [];
  static List<String> tags = [];
  Map<String, dynamic> mapp = Map();

  @override
  void initState(){
    //categoryList =  Provider.of<CategoryListAsset>(context, listen: false).listCategoryExpense;
    for(int i=0; i<categoryList.length; i++){
      mapp[categoryList[i].titleC] = categoryList[i].colorC;
      tags.add(categoryList[i].titleC);
    }
    super.initState();
  }

  dynamic getColorForTitle(String title){
    var color;
    color = mapp[title];
    return color;
  }


  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(tags);
    print(matches.toString());
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  void newTag(Tag tag){
    //Provider.of<CategoryListExpense>(context,listen: false).addCategory(tag);
  }

  void addNew(Asset Asset){
    Provider.of<AssetList>(context,listen: false).addAsset(Asset);
    Provider.of<AssetList>(context,listen: false).mostrar();
  }

  void sucess(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Despesa criada!",style: TextStyle(color: myBlack)),
      duration: Durations.long2,
      backgroundColor: myDarkY,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return 
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
              title: Text("Nova Despesa"),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: DropDownSearchFormField(
                              textFieldConfiguration: TextFieldConfiguration(
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
                                  ),   
                                ),
                                style: formTextStyle,
                                controller: _dropdownSearchFieldController,
                                ),
                                suggestionsCallback: (pattern) {
                                  return getSuggestions(pattern);
                                },
                                itemBuilder: (context, String suggestion) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: myBlue
                                    ),
                                    child: Container(
                                      height: 25,
                                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:  getColorForTitle(suggestion)
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(suggestion),
                                          IconButton(
                                            padding: EdgeInsets.all(0),
                                            onPressed: (){}, 
                                            icon: Icon(Icons.more_vert_rounded),
                                            color: myBlack,
                                            )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                transitionBuilder: (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected: (String suggestion) {
                                  _dropdownSearchFieldController.text = suggestion;
                                },
                                suggestionsBoxController: suggestionBoxController,
                                validator: (value) => value!.isEmpty ? 'www' : null,
                                onSaved: (value){ 
                                  _selectedFruit = value;
                                  },

                                displayAllSuggestionWhenTap: true,
                            ),
                          ),
                                
                            SizedBox(width: 10),
        
                            SizedBox(
                              width: 170,
                              child: GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: myDarkY, width: 2), // Altere a cor conforme necessário
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Data",
            hintStyle: formTextStyle, // Altere conforme necessário
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isCollapsed: true,
            filled: true,
            fillColor: myBlack, // Altere conforme necessário
            labelStyle: formTextStyle, // Altere conforme necessário
          ),
          readOnly: true, // Para que o teclado não apareça
          controller: controllerDate,
          style: formTextStyle,
        ),
      ),
    )
                            ),

                        ],
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
                          items: <String>['Anualmente', 'Todo mês', 'Gasto único']
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

                                  // category
                                  var tag;
                                  int i = Random().nextInt(7);
                                  String colorC;
                                  String titleC = _dropdownSearchFieldController.text;
                                  if(tags.contains(titleC)){
                                    colorC = getColorForTitle(titleC);
                                    tag = categoryList.firstWhere((tag) => tag.titleC == titleC);
                                  }else if(!tags.contains(titleC)){
                                    colorC = "red";
                                    tag = Tag(titleC, colorC); 
                                    newTag(tag);         
                                  }         
                                  // creating Asset
                                  Asset AssetCreating = Asset(titulo, descricao, tag, data ,frequencia!,valor);
                                  addNew(AssetCreating);
                                  Navigator.pop(context);
                                  sucess();     
                                  double a = Provider.of<AssetList>(context,listen: false).totalAssets();
                              }
                            }, 
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
      )));
  }
}