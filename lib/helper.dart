import 'package:flutter/material.dart';

Widget textHelper(String name, double size, String weight) {
  FontWeight? fw = FontWeight.normal;
  switch (weight) {
    case 'bold':
      fw = FontWeight.bold;
      break;
    case '100':
      fw = FontWeight.w100;
      break;
    case '200':
      fw = FontWeight.w200;
      break;
    case '300':
      fw = FontWeight.w300;
      break;
    case '400':
      fw = FontWeight.w400;
      break;
    case '500':
      fw = FontWeight.w500;
      break;
    case '600':
      fw = FontWeight.w600;
      break;
    case '700':
      fw = FontWeight.w700;
      break;
    case '800':
      fw = FontWeight.w800;
      break;
    case '900':
      fw = FontWeight.w900;
      break;
    default:
      fw = FontWeight.normal;
  }

  return Text(
    name,
    style: TextStyle(fontSize: size, fontWeight: fw),
  );
}
