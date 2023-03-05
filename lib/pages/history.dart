import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keuangan/models/model.dart';
import 'package:flutter_keuangan/pages/add.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  final Member data;
  const History({super.key, required this.data});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // int _sortColumnIndex = 0;
  // bool _sortAsc = true;
  // bool _sortMonthAsc = true;

  @override
  Widget build(BuildContext context) {
    final lst = Provider.of<List<Payment>>(context);
    var list = lst;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.data.blockNo} - ${widget.data.name}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return QuizAdd(uid: widget.data.uid);
                },
              ));
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
            DataTable(
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
            )
          ],
        ),
      ),
    );
  }
}
