import 'package:flutter/material.dart';
import 'package:flutter_keuangan/models/model.dart';
import 'package:flutter_keuangan/services/database.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  static const String route = '/history';

  final String uid;
  final String name;

  ///
  const History({super.key, required this.uid, required this.name});

  @override
  Widget build(BuildContext context) {
    ///
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) {
              //     return QuizAdd(uid: widget.data.uid);
              //   },
              // ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Iuran Bulanan 2023',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
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
                Text(
                  'Belum ada data',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                CircularProgressIndicator(),
              ],
            ),
          )
        : DataTable(
            columns: [
              DataColumn(
                label: const Text(
                  'Bulan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
              const DataColumn(
                label: Text(
                  'Nominal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
