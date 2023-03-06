import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/arguments.dart';
import 'models/model.dart';
import 'pages/history.dart';
import 'pages/not_found.dart';
import 'services/database.dart';

MaterialPageRoute<dynamic> pageRoute(Widget page) =>
    MaterialPageRoute(builder: (_) => page);

routeValidation(RouteSettings settings) {
  if (settings.name == '/history') {
    final args = settings.arguments as HistoryArguments;
    if (args.uid.isNotEmpty) {
      return pageRoute(
        MultiProvider(
          providers: [
            StreamProvider<List<Member>>.value(
              initialData: const [],
              value: DatabaseService(uid: '').members,
            ),
            StreamProvider<List<Payment>>.value(
              initialData: const [],
              value: DatabaseService(uid: args.uid).payments,
            ),
          ],
          child: History(uid: args.uid, isAdmin: true),
        ),
      ); // Pass it to BarPage.
    }
  }
  if (settings.name.toString().contains('/history?')) {
    final settingsUri = Uri.parse(settings.name ?? '');
    final uid = settingsUri.queryParameters['uid'].toString();
    if (uid.isNotEmpty) {
      return pageRoute(
        MultiProvider(
          providers: [
            StreamProvider<List<Member>>.value(
              initialData: const [],
              value: DatabaseService(uid: '').members,
            ),
            StreamProvider<List<Payment>>.value(
              initialData: const [],
              value: DatabaseService(uid: uid).payments,
            ),
          ],
          child: History(uid: uid, isAdmin: false),
        ),
      ); // Pass it to BarPage.
    }
  }

  // Let `onUnknownRoute` handle this behavior.
  return pageRoute(const NotFound());
}
