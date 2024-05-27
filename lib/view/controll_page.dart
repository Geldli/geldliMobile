import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/bottom_nav_bar.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/view/assets_page.dart';
import 'package:flutter_application_2/view/dashboard_page.dart';
import 'package:flutter_application_2/view/expensives_page.dart';
import 'package:flutter_application_2/view/home_page.dart';

class ControllPage extends StatefulWidget {
  const ControllPage({super.key});

  @override
  State<ControllPage> createState() => _ControllPageState();
}

class _ControllPageState extends State<ControllPage> {
    int _selectedIndex = 0;
  void navBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    DashboardPage(),
    ExpensivesPage(),
    AssetsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlue,
      bottomNavigationBar: BottomNav(
        onTabChange: (index)=> navBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}