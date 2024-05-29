import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlue,
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("assets")
            ],
          ),
        ),
      ),
    );
  }
}