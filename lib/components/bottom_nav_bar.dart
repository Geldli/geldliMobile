// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNav({required this.onTabChange,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        backgroundColor: myBlack,
        mainAxisAlignment: MainAxisAlignment.center,
        textStyle: navText,
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            iconColor: myWhite,
            iconActiveColor: myDarkY,
            text: "  Home",
            textColor: myDarkY,
          ),
          GButton(
            icon: Icons.bar_chart_rounded,
            iconColor: myWhite,
            iconActiveColor: myDarkY,
            text: "   Dashboard",
          ),
          GButton(
            icon: Icons.shopping_bag,
            iconColor: myWhite,
            iconActiveColor: myDarkY,
            text: "   Despesas",
          ),
          GButton(
            icon: Icons.attach_money_rounded,
            iconColor: myWhite,
            iconActiveColor: myDarkY,
            text: "   Ativos",
          )
      ]),
    );
  }
}