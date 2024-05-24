import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(
      backgroundColor: myDarkY,
      tabs: [
        GButton()
    ]);
  }
}