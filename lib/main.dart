import 'package:flutter/material.dart';
import 'package:flutter_keuangan/models/model.dart';
import 'package:flutter_keuangan/pages/dashboard.dart';
import 'package:flutter_keuangan/pages/history.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Keuangan Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
      // home: History(data: memberData[0]),
      debugShowCheckedModeBanner: false,
    );
  }
}
