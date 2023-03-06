import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../helper.dart';
import '../models/model.dart';
import '../services/database.dart';

class History extends StatelessWidget {
  static const String route = '/history';

  final String uid;
  final bool isAdmin;

  ///
  const History({super.key, required this.uid, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    ///
    return Consumer<List<Member>>(
      builder: (context, data, child) {
        Member m = data.isEmpty
            ? memberDefaultEmpty
            : data.firstWhere((element) => element.uid == uid);

        return Scaffold(
          backgroundColor: Colors.green[50],
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: textHelper('Perumahan MPP Blok I', 20, 'bold'),
            elevation: 0.0,
            automaticallyImplyLeading: isAdmin,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: textHelper('Iuran bulanan', 20, 'bold')),
                const SizedBox(height: 10.0),
                textHelper('Nama: ${m.name}', 18, ''),
                const SizedBox(height: 5.0),
                textHelper('Blok: ${m.blockNo}', 18, ''),
                MultiProvider(
                  providers: [
                    StreamProvider<List<Payment>>.value(
                      initialData: const [],
                      value: DatabaseService(uid: uid).payments,
                    ),
                  ],
                  child: const HistoryDataTable(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class HistoryDataTable extends StatelessWidget {
  const HistoryDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<List<Payment>>(context);
    return list.isEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textHelper('Belum ada data', 20, ''),
                const SizedBox(height: 20.0),
                const SpinKitThreeBounce(color: Colors.blue, size: 50.0),
              ],
            ),
          )
        : DataTable(
            columns: [
              DataColumn(
                label: textHelper('Bulan', 18, 'bold'),
                onSort: (columnIndex, sortAscending) {
                  // setState(
                  //   () {
                  //     if (columnIndex == _sortColumnIndex) {
                  //       _sortAsc = _sortMonthAsc = sortAscending;
                  //     } else {
                  //       _sortColumnIndex = columnIndex;
                  //       _sortAsc = _sortMonthAsc;
                  //     }
                  //     list.sort((a, b) => a.month.compareTo(b.month));
                  //     if (!_sortAsc) {
                  //       list = list.reversed.toList();
                  //     }
                  //   },
                  // );
                },
              ),
              DataColumn(
                label: textHelper('Nominal', 18, 'bold'),
              ),
            ],
            rows: list
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(Text(e.name)),
                      DataCell(Text(e.nominal)),
                    ],
                  ),
                )
                .toList(),
            sortColumnIndex: 0,
            // sortAscending: _sortAsc,
          );
  }
}
