import 'package:flutter/material.dart';

Widget textHelper(String name, double size, String weight) {
  FontWeight? fw = FontWeight.normal;
  switch (weight) {
    case 'bold':
      fw = FontWeight.bold;
      break;
    default:
      fw = FontWeight.normal;
  }

  return Text(
    name,
    style: TextStyle(fontSize: size, fontWeight: fw),
  );
}
