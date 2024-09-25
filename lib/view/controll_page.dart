// ignore_for_file: must_be_immutable, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/bottom_nav_bar.dart';
import 'package:flutter_application_2/controller/user_controller.dart';
import 'package:flutter_application_2/model/User.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/view/assets_page.dart';
import 'package:flutter_application_2/view/dashboard_page.dart';
import 'package:flutter_application_2/view/expensives_page.dart';
import 'package:flutter_application_2/view/home_page.dart';
import 'package:provider/provider.dart';

class ControllPage extends StatefulWidget {
  UserDetails? currentUser;
  ControllPage({
    required this.currentUser,
    super.key});
  @override
  State<ControllPage> createState() => _ControllPageState();
}

class _ControllPageState extends State<ControllPage> {
    String emailUser = "";
    String? userName = "";
    int _selectedIndex = 0;
    List<Widget> _pages = [];

    void navBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  void initState(){


    _pages = [
      HomePage(username: widget.currentUser?.nome ?? "oi", email: widget.currentUser?.email), 
      DashboardPage(), 
      ExpensivesPage(),
      AssetPage()
    ];
    super.initState();
  }

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