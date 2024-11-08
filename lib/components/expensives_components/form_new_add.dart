// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, unused_field, unused_local_variable

import 'dart:math';
import 'package:date_format_field/date_format_field.dart';
import 'package:datetime_picker_field_platform/datetime_picker_field_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/controller/expense_controller.dart';
import 'package:flutter_application_2/controller/tag_expense_controller.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Expense.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
class FormNew extends StatefulWidget {
  FormNew({super.key});

  @override
  State<FormNew> createState() => _FormNewState();
}

class _FormNewState extends State<FormNew> {
  GlobalKey<FormState> chave = GlobalKey();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerValue = TextEditingController();
  TextEditingController controllerTag = TextEditingController();
  int modo = 1; // modo = 1 -> add modo = 2 -> apdate
  DateTime? selectedDate;
  final dateFormat = DateFormat('dd/MM/yyyy'); // Formato da data

  ExpenseController _expenseController = ExpenseController();
  TagExpenseController _tagExpenseController = TagExpenseController();

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
  final TextEditingController _dropdownSearchFieldController = TextEditingController();
  String? _selectedFruit;
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  List<Tag> categoryList =  [];
  static List<String> tags = [];
  Map<String, String> mapp = Map();


void loadTags() async {
  await _tagExpenseController.getTagByUserId(3); // Substitua pelo ID do usuário
  setState(() {
    categoryList = _tagExpenseController.tagExpenseList;
    print("opa" + categoryList.toString());
    mapp.clear(); // Limpe o mapa antes de preenchê-lo novamente
    tags.clear(); // Limpe a lista de tags antes de preenchê-la novamente
    for (int i = 0; i < categoryList.length; i++) {
      mapp[categoryList[i].titleC] = categoryList[i].colorC;
      tags.add(categoryList[i].titleC);
    }
  });
}

@override
void initState() {
  super.initState;
  loadTags();
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
                                        color:  Colors.red
                                        //getColorForTitle(suggestion)
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
                            ElevatedButton(onPressed: () async {
                              if(chave.currentState!.validate()){
                                var status;
                                  String? titulo = controllerTitle.text;
                                  String data = controllerDate.text;
                                  double valor = double.parse(controllerValue.text);
                                  String descricao = controllerDesc.text;
                                  // category
                                  var tag;
                                  //int i = Random().nextInt(7);
                                  String colorC; 
                                  String titleC = _dropdownSearchFieldController.text.trim();
                                                                    tag = Tag(titleC, "blue"); // Cria a tag com cor em String
                                  if (tags.map((tag) => tag.toLowerCase()).contains(titleC.toLowerCase())) {
                                    colorC = getColorForTitle(titleC);
                                    tag = categoryList.firstWhere((tag) => tag.titleC == titleC);
                                  _tagExpenseController.createExpenseTag(tag, 3);

                                  } else {
                                  colorC = Colors.red.toString(); // Converte a cor para String
                                 }
                                  // creating expensive
                                  Expense currentExpense = Expense(titulo, data, valor.toDouble(), descricao, "a", tag);
                                  String result = await _expenseController.createExpense(currentExpense, 3); // Passando o id do usuário como exemplo

                                  if (result == 'success') {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Despesa criada com sucesso!')));
                                  }
                                  else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao criar/atualizar despesa')));
                                  }
                                    
                                  Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: myDarkY
                            ),
                            child: 1 == 1 ? Text("CRIAR") : Text("CRIAR")
                            
                            )
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