// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
       body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: Text("Sobre nós", style: headerAbout),
                iconTheme: IconThemeData(
                  color: myWhite
                ),
                backgroundColor: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Image.asset("../assets/images/cat.png", width: 150),
                    Text(
                      "Bem-vindo ao Geldli!",
                      maxLines: 1,  
                      style: aboutTextH1,
                      ),
                    SizedBox(height: 10),
                    Text(
                      "Somos uma plataforma intuitiva e poderosa de gerenciamento financeiro, projetada para simplificar sua vida financeira. Com recursos avançados e uma interface amigável, capacitamos você a tomar decisões informadas e alcançar estabilidade financeira. Junte-se a nós e simplifique suas finanças, um clique de cada vez.",
                      maxLines: 10,  
                      style: aboutText,
                      textAlign: TextAlign.justify,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
       ),
    );
  }
}