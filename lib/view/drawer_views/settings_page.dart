// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/profile_components/body_profile.dart';
import 'package:flutter_application_2/components/profile_components/cover_profile.dart';
import 'package:flutter_application_2/components/profile_components/picture_profile.dart';



class SettingsPage extends StatefulWidget {
  String email;
  String name;
  SettingsPage({
    required this.email,
    required this.name,
    super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: [
              CoverProfile(email: widget.email,name: widget.name),
              BodyProfile()
            ],
          ),
        PictureProfile(name: widget.name,)
        ],
      )
    );
  }
}