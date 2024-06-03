// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';

class PictureProfile extends StatelessWidget {
  const PictureProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: myBlack,
                width: 7,
              )
            ),
            child: CircleAvatar(
            backgroundImage: AssetImage("..//../../assets/images/profile_picture.png"),
            radius: 50,
          ),
          ),
          Text("Bruno Lima",style: TextStyle(color: myWhite),)
        ],
      )
      );
  }
}