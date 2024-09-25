// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';

class PictureProfile extends StatelessWidget {
  String? name;
  PictureProfile({required this.name,super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
          Text("nome de usuário", style: profileH3),
          Text(name!, style: profileH1)
        ],
      )
      );
  }
}