import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/home_tabs.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return HomeTabs();
  }
}