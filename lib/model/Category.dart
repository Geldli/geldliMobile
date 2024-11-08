import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';

class Tag {
  String titleC;
  String colorC; // Cor mantida como string

  Tag(this.titleC, this.colorC);

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['id'] as String? ?? '', // Garante que titleC nunca seja null
      json['cores'] as String? ?? 'red', // Garante que colorC tenha um valor padrão
    );
  }

String colorToString(Color color) {
  return '#${color.value.toRadixString(16).substring(2)}'; // Remove o prefixo 'ff'
}

  Color toColor() {
    return colorsForChoice[0];
  }

  factory Tag.fromString(String title) {
    return Tag(title, 'red'); // Ou outra cor padrão
  }
}
