import 'package:flutter/material.dart';

class ExpensivesPage extends StatefulWidget {
  const ExpensivesPage({super.key});

  @override
  State<ExpensivesPage> createState() => _ExpensivesPageState();
}

class _ExpensivesPageState extends State<ExpensivesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
                          Text("expensives")  
            ],
          ),
        ),
      ),
    );
  }
}