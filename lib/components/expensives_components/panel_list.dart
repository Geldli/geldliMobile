// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, sort_child_properties_last

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/components/expensives_components/expensive_view.dart';
import 'package:flutter_application_2/components/expensives_components/list_tags.dart';
import 'package:flutter_application_2/controller/expense_controller.dart';
import 'package:flutter_application_2/controller/tag_expense_controller.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Expense.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:provider/provider.dart';

class PanelList extends StatefulWidget {
  const PanelList({super.key});
  @override
  State<PanelList> createState() => _PanelListState();
}

class _PanelListState extends State<PanelList> {
  double totalValue = 0;

  ExpenseController _expenseController = ExpenseController();
  TagExpenseController _tagExpenseController = TagExpenseController();

  TextEditingController query = TextEditingController();
  List<Expense> response = [];
  var controller = 0;

  final int userId = 4;
 @override
  
  void initState() {
    super.initState();
    // Carregar despesas quando o widget é inicializado
    loadExpenses();
  }

Future<void> loadExpenses() async {
  try {
    await _expenseController.getExpenseByUserId(userId);
    print("Despesaitas:");
        _expenseController.expenseList.forEach((element) {
          print(element.titleD);
        });
     // Verifiq
      setState(() {
      response = _expenseController.expenseList;
      totalValue = _expenseController.totalExpensives();
    });
  } catch (e) {
    print('Erro ao carregar despesas: $e');
  }
}


void handleCategorySelected(Tag? selectedTag) async {
  if (selectedTag == null) return;

  List<Expense> filteredExpenses = await _expenseController.getByCategory(userId, selectedTag.titleC);

  setState(() {
    this.selectedCategory = selectedTag; // Atualiza a categoria selecionada
    response = filteredExpenses; // Atualiza a lista de despesas para exibir apenas as filtradas
    totalValue = filteredExpenses.fold(0, (sum, expense) => sum + expense.valueD);  });
}


void getExpensivesByQuery() {
  String searchQuery = query.text.trim(); // Remove espaços em branco

  if (searchQuery.isEmpty) {
    // Se a consulta estiver vazia, reseta a resposta para a lista completa
    setState(() {
      response = List.from(_expenseController.expenseList);
      totalValue = _expenseController.totalExpensives();
    });
    return;
  }

  // Filtra as despesas pela consulta
  List<Expense> filteredExpenses = _expenseController.expenseList.where((expensive) {
    return expensive.titleD.toUpperCase().contains(searchQuery.toUpperCase());
  }).toList();

  setState(() {
    response = filteredExpenses; // Atualiza a lista de despesas
    totalValue = filteredExpenses.fold(0, (sum, expense) => sum + expense.valueD); // Atualiza o total
  });
}
  
  Tag? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              ListTag(onCategorySelected: handleCategorySelected),
              SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 0, 5),
                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20), 
                  decoration: BoxDecoration(
                    border: Border.all(color: myWhite,width: 2),borderRadius: BorderRadius.circular(10) ),
                  child: Text("R\$ " + totalValue.toStringAsFixed(2), style: TextStyle(color: myWhite, fontSize: 16, fontWeight: FontWeight.bold),)),
              ),
              // barra de pesquisa
              SizedBox(height: 10),
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
                      response = _expenseController.expenseList;
                      totalValue = _expenseController.totalExpensives();
                      setState(() {
                        
                      });
                    },
                  )
                ],
              ),
    
              SizedBox(height: 15),
    
              Expanded(
                child: ListView.builder(
                  itemCount: response.isNotEmpty ? response.length : _expenseController.expenseList.length,
                  itemBuilder: (context, index) {
                  Expense thisExpense = response.isNotEmpty ? response[index] : _expenseController.expenseList[index];
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
                          builder: (BuildContext context) => ExpensiveView(thisExpensive: thisExpense)
                          ),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                          decoration: BoxDecoration(
                            color: thisExpense.category!.toColor(),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(thisExpense.category!.titleC, style: categoryText),
                        ),
                        leading: PopupMenuButton(
                          iconColor: myWhite,
                          color: myWhite,
                          onSelected: (value) {
                            if(value == "delete"){
                             _expenseController.delete(4, thisExpense.titleD);
                            }  
                            if(value == "edit"){
                             _expenseController.edit(thisExpense, 4);
                            }  
                            setState(() {
                              response.remove(thisExpense);
                              totalValue = _expenseController.totalExpensives();                            
                              });
                          },
                          itemBuilder: (BuildContext context){
                            return const [
                              PopupMenuItem(
                                child: Text("Editar"),
                                value: 'edit',
                                height: 35,
                              ),
                              PopupMenuItem(
                                child: Text("Excluir"),
                                value: 'delete',
                                height: 35,
                              )
                            ];
                          }
                          ),
                        title: Text(thisExpense.titleD),
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
    
    );
  }
}