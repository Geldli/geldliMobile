import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/dashboard/bar_chart_asset_expense.dart';
import 'package:flutter_application_2/ui/colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlue,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 350, width: 500, child: BarChartSample2())
          ],
        ),
      ),
    );
  }
}