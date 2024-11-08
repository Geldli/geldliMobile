import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/dashboard/bar_chart_asset_expense.dart';
import 'package:flutter_application_2/components/dashboard/filter.dart';
import 'package:flutter_application_2/components/expensives_components/list_tags.dart';
import 'package:flutter_application_2/controller/expense_controller.dart';
import 'package:flutter_application_2/model/Category.dart';
import 'package:flutter_application_2/model/Expense.dart';
import 'package:flutter_application_2/ui/colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  ExpenseController _expenseController = ExpenseController();

  final int userId = 4;

  void handleCategorySelected(Tag? selectedTag) async {
  if (selectedTag == null) return;

  List<Expense> filteredExpenses = await _expenseController.getByCategory(userId, selectedTag.titleC);

  setState(() {
   // this.selectedCategory = selectedTag; // Atualiza a categoria selecionada
   // response = filteredExpenses; // Atualiza a lista de despesas para exibir apenas as filtradas
    //totalValue = filteredExpenses.fold(0, (sum, expense) => sum + expense.valueD); 
     });
}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilterDash(),
            //SizedBox(height: 350, width: 500, child: BarChartSample2())
          ],
        ),
      ),
    );
  }
}