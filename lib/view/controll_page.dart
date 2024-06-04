// ignore_for_file: must_be_immutable, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/bottom_nav_bar.dart';
import 'package:flutter_application_2/model/UserList.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/view/assets_page.dart';
import 'package:flutter_application_2/view/dashboard_page.dart';
import 'package:flutter_application_2/view/expensives_page.dart';
import 'package:flutter_application_2/view/home_page.dart';
import 'package:provider/provider.dart';

class ControllPage extends StatefulWidget {
  String email;
  ControllPage({
    required this.email,
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
    setState(() {
      emailUser = widget.email;
      userName = Provider.of<UserList>(context, listen: false).findUserNameByEmail(widget.email);
    });

    _pages = [
    HomePage(username: userName ?? "oi",email: emailUser), 
    DashboardPage(), 
    ExpensivesPage(),
    AssetsPage()
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