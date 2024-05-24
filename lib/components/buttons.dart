import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';
import 'package:flutter_application_2/ui/text.dart';
import 'package:flutter_application_2/view/register_page.dart';

class MyButton extends StatefulWidget {
  String myText;
  void Function()? onPressed;
  MyButton({ required this.myText, required this.onPressed,super.key});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
          backgroundColor: myDarkY,
          elevation: 0,
          fixedSize: Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25))
        ),
        child: Text(widget.myText,style: styleHint,)),

        SizedBox(height: 20),

        TextButton(
        onPressed: (){
          
        },
        child: Align(
            alignment: Alignment.center,
            child: Text("Ainda não tenho uma conta!",style: styleLink,)
        )),
      ],
    );                
  }
}