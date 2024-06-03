// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';

class CoverProfile extends StatefulWidget {
  const CoverProfile({super.key});

  @override
  State<CoverProfile> createState() => _CoverProfileState();
}

class _CoverProfileState extends State<CoverProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("..//../../assets/images/cover_profile.png"),
        fit: BoxFit.cover)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Icon(Icons.more_vert_rounded,color: myWhite,)
          ],
        ),
      ),
    );
  }
}