// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/profile_components/body_profile.dart';
import 'package:flutter_application_2/components/profile_components/cover_profile.dart';
import 'package:flutter_application_2/components/profile_components/picture_profile.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

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
              CoverProfile(),
              BodyProfile()
            ],
          ),
        PictureProfile()
        ],
      )
    );
  }
}