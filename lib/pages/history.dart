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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.arrow_back_ios, size: 20.0),
                textHelper('Iuran bulanan 2023', 20, 'bold'),
                // Icon(Icons.arrow_forward_ios, size: 20.0),
              ],
            ),
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: isAdmin,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textHelper(m.name, 18, '500'),
                        const SizedBox(height: 5.0),
                        textHelper(m.blockNo, 14, ''),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
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

class HistoryDataTable extends StatefulWidget {
  const HistoryDataTable({super.key});

  @override
  State<HistoryDataTable> createState() => _HistoryDataTableState();
}

class _HistoryDataTableState extends State<HistoryDataTable> {
  List<Payment> list = [];
  bool _sortAsc = false;

  @override
  Widget build(BuildContext context) {
    list = Provider.of<List<Payment>>(context);

    ///
    if (list.isEmpty) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textHelper('Belum ada data', 20, ''),
            const SizedBox(height: 20.0),
            const SpinKitThreeBounce(color: Colors.blue, size: 50.0),
          ],
        ),
      );
    } else {
      /// Sort list
      if (_sortAsc) {
        list.sort((a, b) => a.month.compareTo(b.month));
      } else {
        list.sort((a, b) => b.month.compareTo(a.month));
      }
      return Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: DataTable(
            columns: [
              DataColumn(
                label: textHelper('Bulan', 15, '500'),
                onSort: (columnIndex, sortAscending) {
                  setState(() => _sortAsc = sortAscending);
                },
              ),
              DataColumn(
                label: textHelper('Nominal', 15, '500'),
              ),
            ],
            rows: list
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(textHelper(e.name, 15, '')),
                      DataCell(textHelper(e.nominal, 15, '')),
                    ],
                  ),
                )
                .toList(),
            sortColumnIndex: 0,
            sortAscending: _sortAsc,
          ),
        ),
      );
    }
  }
}
