import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../helper.dart';
import '../models/model.dart';
import '../services/database.dart';

class History extends StatefulWidget {
  static const String route = '/history';

  final String uid;
  final bool isAdmin;

  ///
  const History({super.key, required this.uid, required this.isAdmin});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool showPrevYear = true;
  bool showNextYear = true;
  int _year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    ///
    return Consumer<List<Member>>(
      builder: (context, data, child) {
        Member m;
        if (data.isEmpty) {
          m = memberDefaultEmpty;
        } else {
          m = data.firstWhere((element) => element.uid == widget.uid);
        }

        return Scaffold(
          backgroundColor: Colors.green[50],
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (_year > minYear) {
                      setState(() => _year--);
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 20.0),
                  color: (_year > minYear) ? Colors.white : Colors.transparent,
                ),
                textHelper('Iuran bulanan $_year', 20, 'bold',
                    color: Colors.white),
                IconButton(
                  onPressed: () {
                    if (_year < maxYear) {
                      setState(() => _year++);
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                    color: _year < maxYear ? Colors.white : Colors.transparent,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: widget.isAdmin,
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
                      value: DatabaseService(uid: widget.uid).payments,
                    ),
                  ],
                  child: HistoryDataTable(year: _year),
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
  final int year;
  const HistoryDataTable({super.key, required this.year});

  @override
  State<HistoryDataTable> createState() => _HistoryDataTableState();
}

class _HistoryDataTableState extends State<HistoryDataTable> {
  List<Payment> list = [];
  bool _sortAsc = false;

  @override
  Widget build(BuildContext context) {
    list = Provider.of<List<Payment>>(context)
        .where((element) => element.year == widget.year)
        .toList();

    ///
    if (list.isEmpty) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textHelper('Belum ada data', 20, ''),
            const SizedBox(height: 20.0),
            const SpinKitThreeBounce(color: Colors.green, size: 50.0),
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

      ///
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
