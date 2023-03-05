import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keuangan/models/model.dart';

class History extends StatefulWidget {
  final Member data;
  const History({super.key, required this.data});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _sortColumnIndex = 0;
  bool _sortAsc = true;
  bool _sortMonthAsc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.data.block} - ${widget.data.name}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
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
                const DataColumn(
                  label: Text(
                    'No',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: const Text(
                    'Bulan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onSort: (columnIndex, sortAscending) {
                    setState(
                      () {
                        if (columnIndex == _sortColumnIndex) {
                          _sortAsc = _sortMonthAsc = sortAscending;
                        } else {
                          _sortColumnIndex = columnIndex;
                          _sortAsc = _sortMonthAsc;
                        }
                        widget.data.payments
                            .sort((a, b) => a.month.compareTo(b.month));
                        if (!_sortAsc) {
                          widget.data.payments =
                              widget.data.payments.reversed.toList();
                        }
                      },
                    );
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
              rows: widget.data.payments
                  .map(
                    (e) => DataRow(
                      cells: [
                        const DataCell(Text('-')),
                        DataCell(Text(e.name)),
                        DataCell(Text(e.nominal)),
                      ],
                    ),
                  )
                  .toList(),
              sortColumnIndex: 1,
              sortAscending: _sortAsc,
            )
          ],
        ),
      ),
    );
  }
}
