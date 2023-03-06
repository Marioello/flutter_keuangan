import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keuangan/configs/firebase';
import 'package:flutter_keuangan/constants.dart';
import 'package:flutter_keuangan/models/arguments.dart';
import 'package:flutter_keuangan/models/model.dart';
import 'package:flutter_keuangan/pages/dashboard.dart';
import 'package:flutter_keuangan/pages/history.dart';
import 'package:flutter_keuangan/pages/not_found.dart';
import 'package:flutter_keuangan/services/database.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInit();
  await initializeDateFormatting(localFormat, null).then((_) {
    return runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Dashboard.route,
      onGenerateRoute: (settings) {
        if (settings.name == '/history') {
          final args = settings.arguments as HistoryArguments;
          if (args.uid.isNotEmpty) {
            return pageRoute(
              MultiProvider(
                providers: [
                  StreamProvider<List<Payment>>.value(
                    initialData: const [],
                    value: DatabaseService(uid: args.uid).payments,
                  ),
                ],
                child: History(uid: args.uid, name: args.name),
              ),
            ); // Pass it to BarPage.
          }
        }
        if (settings.name.toString().contains('/history?')) {
          final settingsUri = Uri.parse(settings.name ?? '');
          final uid = settingsUri.queryParameters['uid'].toString();
          final name = settingsUri.queryParameters['name'].toString();
          if (uid.isNotEmpty) {
            return pageRoute(
              MultiProvider(
                providers: [
                  StreamProvider<List<Payment>>.value(
                    initialData: const [],
                    value: DatabaseService(uid: uid).payments,
                  ),
                ],
                child: History(uid: uid, name: name),
              ),
            ); // Pass it to BarPage.
          }
        }

        // Let `onUnknownRoute` handle this behavior.
        return pageRoute(const NotFound());
      },
      routes: {
        Dashboard.route: (context) {
          return MultiProvider(
            providers: [
              StreamProvider<List<Member>>.value(
                initialData: const [],
                value: DatabaseService(uid: '').members,
              ),
            ],
            child: const Dashboard(),
          );
        },
        // History.route: (context) => const History(),
      },
      title: 'Flutter Keuangan Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MultiProvider(
      //   providers: [
      //     StreamProvider<List<Member>>.value(
      //       initialData: const [],
      //       value: DatabaseService(uid: '').members,
      //     ),
      //   ],
      //   child: const Dashboard(),
      // ),
      // home: History(data: memberData[0]),
      debugShowCheckedModeBanner: false,
    );
  }

  MaterialPageRoute<dynamic> pageRoute(Widget page) {
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }
}
