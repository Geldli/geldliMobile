// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/view/controll_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: myLightY),
        useMaterial3: true,
      ),
      home: ControllPage(),
    );
  }
}
