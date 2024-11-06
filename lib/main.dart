// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/user_datas.dart';
import 'package:flutter_application_2/view/auth_views/register_page.dart';
import 'package:flutter_application_2/view/dashboard_page.dart';
import 'package:flutter_application_2/view/expensives_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDatas()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisterPage(),
      ),
      );
  }
}
