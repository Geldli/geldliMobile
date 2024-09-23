// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/components/expensives_components/expensive_view.dart';
import 'package:flutter_application_2/components/expensives_components/list_tags.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Expensive.dart';
import 'package:flutter_application_2/controller/ExpensiveList.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class PanelList extends StatefulWidget {
  const PanelList({super.key});
  @override
  State<PanelList> createState() => _PanelListState();
}

class _PanelListState extends State<PanelList> {

  void deleteExpensive(Expensive expensive){
    Provider.of<ExpensiveList>(context, listen: false).removeExpensive(expensive);
  }

  TextEditingController query = TextEditingController();
  List<Expensive> response = [];
  var controller = 0;

  void getExpensivesByQuery() {
    response.clear();
    String searchQuery = query.text.trim(); // Remove espaços em branco

    if (searchQuery.isEmpty) {
      return; // Não faz nada se a consulta estiver vazia
    }

    Provider.of<ExpensiveList>(context, listen: false).listExpensives.forEach((expensive) {
      String title = expensive.titleD.toUpperCase();
      if (title.contains(searchQuery.toUpperCase())) {
        response.add(expensive);
      }
    });

    setState(() {}); // Atualiza o estado para refletir as mudanças
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensiveList>(builder: (context, value, child) =>
      SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          child: Center(
            child: Column(
              children: [
                ListTag(),
                SizedBox(height: 20),
                ExpensiveList().listExpensives.isNotEmpty ?
                Text("Clique no bloco da despesa para ver detalhes.",style: listViewTitle):
                Text("Aqui você poderá controlar suas despesas depois forem criadas.",style: listViewTitle),

                SizedBox(height: 20),
                // barra de pesquisa
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      child: TextField(
                        controller: query,
                        decoration: InputDecoration(
                          hintText: "Pesquisar despesas",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          filled: true,
                          fillColor: myWhite,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: getExpensivesByQuery,
                      icon: Icon(Icons.search,color: myWhite, size: 25)
                      ),
                    IconButton(
                      icon: Icon(Icons.clear,color: myWhite, size: 25),
                      onPressed: (){
                        query.text = "";
                        response.clear();
                        setState(() {
                          
                        });
                      },
                    )
                  ],
                ),

                SizedBox(height: 15),

                Expanded(
                  child: ListView.builder(
                    itemCount: response.isNotEmpty ? response.length : value.listExpensives.length,
                    itemBuilder: (context, index) {
                      Expensive thisExpensive = response.isNotEmpty ? response[index] : value.listExpensives[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: myBlack, 
                          borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),   
                        child: ListTile(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => ExpensiveView(thisExpensive: thisExpensive)
                            ),
                          trailing: Container(
                            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                            decoration: BoxDecoration(
                              color: thisExpensive.category!.colorC,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(thisExpensive.category!.titleC, style: categoryText),
                          ),
                          leading: PopupMenuButton(
                            iconColor: myWhite,
                            color: myWhite,
                            onSelected: (value) {
                              if(value == "delete"){
                                deleteExpensive(thisExpensive);
                              }  
                            },
                            itemBuilder: (BuildContext context){
                              return const [
                                PopupMenuItem(
                                  child: Text("Excluir"),
                                  value: 'delete',
                                  height: 35,
                                )
                              ];
                            }
                            ),
                          title: Text(thisExpensive.titleD),
                          titleTextStyle: listViewTitle,
                        ),                                    
                      );                    
                    },
                    )
                )
              ],
            ),
          ),
        )
      
      ),
    );
  }
}