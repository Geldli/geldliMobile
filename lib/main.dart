// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/expensives_components/expensive_view.dart';
import 'package:flutter_application_2/controller/AssetList.dart';
import 'package:flutter_application_2/controller/CategoryList.dart';
import 'package:flutter_application_2/controller/ExpensiveList.dart';
import 'package:flutter_application_2/controller/UserList.dart';
import 'package:flutter_application_2/controller/userDatas.dart';
import 'package:flutter_application_2/view/auth_views/register_page.dart';
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
        ChangeNotifierProvider(create: (context) => UserList()),
        ChangeNotifierProvider(create: (context) => ExpensiveList()),
        ChangeNotifierProvider(create: (context) => CategoryList()),
        ChangeNotifierProvider(create: (context) => AssetList()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ExpensivesPage(),
      ),
      );
  }
}
