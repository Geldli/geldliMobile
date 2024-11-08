import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/expense_controller.dart';
import 'package:flutter_application_2/controller/asset_controller.dart';  // Importa o controlador de ativos
import 'package:flutter_application_2/model/Expense.dart';
import 'package:flutter_application_2/model/Asset.dart';  // Importa o modelo de ativo
import 'package:flutter_application_2/ui/colors.dart';

class FilterDash extends StatefulWidget {
  const FilterDash({super.key});

  @override
  State<FilterDash> createState() => _FilterDashState();
}

class _FilterDashState extends State<FilterDash> {
  ExpenseController _expenseController = ExpenseController();
  AssetController _assetController = AssetController();  // Controlador de ativos
  List<Expense> _expenseList = [];  // Lista de despesas original
  List<Expense> _filteredExpenseList = [];  // Lista de despesas filtradas
  List<Asset> _assetList = [];  // Lista de ativos original
  List<Asset> _filteredAssetList = [];  // Lista de ativos filtrados
  List<int> _years = [];  // Lista de anos para o dropdown
  int? _selectedYear;  // Ano selecionado

  final int userId = 4;

  // Carregar as despesas, ativos e anos ao iniciar a página
  Future<void> loadData() async {
    try {
      // Carrega as despesas do usuário
      await _expenseController.getExpenseByUserId(userId);
      _expenseList = _expenseController.expenseList;

      // Carrega os ativos do usuário
      await _assetController.getAssetByUserId(userId);
      _assetList = _assetController.assetList;

      // Extrair anos únicos das despesas e ativos
      Set<int> yearsSet = {};
      for (var expense in _expenseList) {
        DateTime expenseDate = DateTime.parse(expense.dateToRemember);
        yearsSet.add(expenseDate.year);
      }
      for (var asset in _assetList) {
        DateTime assetDate = DateTime.parse(asset.dateToRemember);
        yearsSet.add(assetDate.year);
      }

      // Verifique se o widget ainda está montado antes de chamar setState
      if (mounted) {
        setState(() {
          // Adiciona os anos únicos na lista e os ordena
          _years = yearsSet.toList()..sort();
          _filteredExpenseList = List.from(_expenseList); // Inicializa a lista filtrada com todas as despesas
          _filteredAssetList = List.from(_assetList); // Inicializa a lista filtrada com todos os ativos

          if (_years.isNotEmpty) {
            _selectedYear = _years[0]; // Seleciona automaticamente o primeiro ano
            // Filtra as despesas e ativos automaticamente com o primeiro ano
            _filteredExpenseList = filterExpensesByYear(_selectedYear!);
            _filteredAssetList = filterAssetsByYear(_selectedYear!);
          }
        });
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }

  // Filtra as despesas pelo ano selecionado
  List<Expense> filterExpensesByYear(int year) {
    return _expenseList.where((expense) {
      DateTime expenseDate = DateTime.parse(expense.dateToRemember);
      return expenseDate.year == year;
    }).toList();
  }

  // Filtra os ativos pelo ano selecionado
  List<Asset> filterAssetsByYear(int year) {
    return _assetList.where((asset) {
      DateTime assetDate = DateTime.parse(asset.dateToRemember);
      return assetDate.year == year;
    }).toList();
  }

  // Calcula o total de despesas
  double calculateTotalExpense(List<Expense> expenses) {
    return expenses.fold(0.0, (total, expense) => total + expense.valueD);
  }

  // Calcula o total de ativos
  double calculateTotalAsset(List<Asset> assets) {
    return assets.fold(0.0, (total, asset) => total + asset.valueD);
  }

  // Encontra a categoria de despesas mais frequente
  String findMostFrequentExpenseCategory(List<Expense> expenses) {
    Map<String, int> categoryCount = {};

    // Conta as ocorrências de cada categoria
    for (var expense in expenses) {
      String category = expense.category!.titleC;
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
    }

    // Encontra a categoria mais frequente
    if (categoryCount.isNotEmpty) {
      var mostFrequent = categoryCount.entries.reduce((a, b) => a.value > b.value ? a : b);
      return mostFrequent.key;
    }

    return 'Nenhuma categoria';
  }

  // Encontra a categoria de ativos mais frequente
  String findMostFrequentAssetCategory(List<Asset> assets) {
    Map<String, int> categoryCount = {};

    // Conta as ocorrências de cada categoria
    for (var asset in assets) {
      String category = asset.category!.titleC;
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
    }

    // Encontra a categoria mais frequente
    if (categoryCount.isNotEmpty) {
      var mostFrequent = categoryCount.entries.reduce((a, b) => a.value > b.value ? a : b);
      return mostFrequent.key;
    }

    return 'Nenhuma categoria';
  }



  // Calcula o total de despesas de cada mês
  Map<int, double> calculateMonthlyTotal(List<Expense> expenses) {
    Map<int, double> monthlyTotals = {};

    for (var expense in expenses) {
      DateTime expenseDate = DateTime.parse(expense.dateToRemember);
      int month = expenseDate.month;
      double value = expense.valueD;

      if (monthlyTotals.containsKey(month)) {
        monthlyTotals[month] = monthlyTotals[month]! + value;
      } else {
        monthlyTotals[month] = value;
      }
    }

    return monthlyTotals;
  }


 String findMonthWithHighestExpenses(Map<int, double> monthlyTotals) {
    if (monthlyTotals.isEmpty) {
      return 'Nenhum dado disponível';
    }

    int highestMonth = monthlyTotals.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return _getMonthName(highestMonth);
  }

  // Função para converter número do mês em nome do mês
  String _getMonthName(int month) {
    const months = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];
    return months[month - 1];
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        Map<int, double> monthlyTotals = calculateMonthlyTotal(_filteredExpenseList);
    return Container(
      decoration: BoxDecoration(
      ),
      child: Expanded(
        child: Column(
          children: [
            // Dropdown para selecionar o ano
            DropdownButton<int>(
              value: _selectedYear,
              hint: Text("Selecione o anro", style: TextStyle(color: myWhite)),
              items: _years.map((year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString(), style: TextStyle(color: myWhite)),
                );
              }).toList(),
              onChanged: (year) {
                setState(() {
                  _selectedYear = year;
                  // Filtra as despesas e ativos quando um ano é selecionado
                  _filteredExpenseList = filterExpensesByYear(year!);
                  _filteredAssetList = filterAssetsByYear(year);
                });
              },
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                                              width: 220,
        
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                    color: myBlue,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.numbers, color: myDarkY,),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Qntd de Ativos',
                            style: TextStyle(color: myWhite),
                          ),
                          Text(
                            '${_filteredAssetList.length}',
                            style: TextStyle(color: myWhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Container(
                                                              width: 220,
        
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                    color: myBlue,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.numbers, color: myDarkY,),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Qntd de Despesas',
                            style: TextStyle(color: myWhite),
                          ),
                          Text(
                            '${_filteredExpenseList.length}',
                            style: TextStyle(color: myWhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
                  SizedBox(height: 20,),
            // Exibe o valor total de ativos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                    color: myBlue,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.numbers, color: myDarkY,),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Soma de Ativos',
                            style: TextStyle(color: myWhite),
                          ),
                          Text(
                            '${calculateTotalAsset(_filteredAssetList).toStringAsFixed(2)}',
                            style: TextStyle(color: myWhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                    color: myBlue,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.numbers, color: myDarkY,),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Soma de Despesas',
                            style: TextStyle(color: myWhite),
                          ),
                          Text(
                            '${calculateTotalExpense(_filteredExpenseList).toStringAsFixed(2)}',
                            style: TextStyle(color: myWhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
        
        
            Container(
                              width: 450,
        
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              decoration: BoxDecoration(
                color: myBlue,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.numbers, color: myDarkY,),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        'Categoria em que você mais recebeu',
                        style: TextStyle(color: myWhite),
                      ),
                      Text(
                        '${findMostFrequentAssetCategory(_filteredAssetList)}',
                        style: TextStyle(color: myWhite),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                            SizedBox(height: 20),
        
            Container(
                              width: 450,
        
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                color: myBlue,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.numbers, color: myDarkY,),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        'Categoria em que você mais gastou',
                        style: TextStyle(color: myWhite),
                      ),
                      Text(
                        '${findMostFrequentExpenseCategory(_filteredExpenseList)}',
                        style: TextStyle(color: myWhite),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                  SizedBox(height: 20,),
        
            Container(
                              width: 450,
        
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                color: myBlue,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.numbers, color: myDarkY,),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        'Mês com Maior Total de Despesas:',
                        style: TextStyle(color: myWhite),
                      ),
                      Text(
                        findMonthWithHighestExpenses(monthlyTotals),
                        style: TextStyle(color: myWhite),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                  SizedBox(height: 20,),
        
             Container(
                              width: 450,
        
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                color: myBlue,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.numbers, color: myDarkY,),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        "Patrimônio",
                        style: TextStyle(color: myWhite),
                      ),
                      Text(
                        (calculateTotalAsset(_filteredAssetList) - calculateTotalExpense(_filteredExpenseList)).toStringAsFixed(2),
                        style: TextStyle(color: myWhite),
                      ),
                    ],
                  ),
                ],
              ),
           ),
          ],
        ),
      ),
    );
  }
}
