import 'package:flutter/material.dart';

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
    // Converte a string de cor em um objeto Color
    switch (colorC.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      // Adicione mais cores conforme necessário
      default:
        return Colors.black; // Cor padrão se não for reconhecida
    }
  }

  factory Tag.fromString(String title) {
    return Tag(title, 'red'); // Ou outra cor padrão
  }
}
