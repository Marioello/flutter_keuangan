import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/model.dart';

// Regex
final RegExp nameRegExp = RegExp('[a-zA-Z]');

// Local format
const String localFormat = 'id_ID';

currFormat(String number) {
  double? value = double.tryParse(number);
  NumberFormat result =
      NumberFormat.currency(locale: localFormat, symbol: "Rp. ");
  return result.format(value);
}

dateFormat(DateTime date, {String format = 'MMMM yyyy'}) {
  DateFormat result = DateFormat(format, localFormat);
  return result.format(date);
}

// Color
const Color appBaseColorDark = Colors.green;
final Color appBaseColorLight = Colors.green.shade50;
const Color cardColor = Colors.white;
const Color fontColor = Colors.white;
final List ansColors = [Colors.red, Colors.green, Colors.blue, Colors.amber];

// Model
Member memberDefaultEmpty = Member(uid: '', name: 'Dummy', blockNo: 'I/00');
// Decoration
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

// Year, month, date
final year = List.generate(5, (i) => i + 2022);

// final month = [
//   Month(name: 'Januari', value: 1),
//   Month(name: 'Februari', value: 2),
//   Month(name: 'Maret', value: 3),
//   Month(name: 'April', value: 4),
//   Month(name: 'Mei', value: 5),
//   Month(name: 'Juni', value: 6),
//   Month(name: 'Juli', value: 7),
//   Month(name: 'Agustus', value: 8),
//   Month(name: 'September', value: 9),
//   Month(name: 'Oktober', value: 10),
//   Month(name: 'November', value: 11),
//   Month(name: 'Desember', value: 12),
// ];
