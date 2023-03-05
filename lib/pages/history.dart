import 'package:flutter/material.dart';
import 'package:flutter_keuangan/models/model.dart';

class History extends StatelessWidget {
  final Member data;
  const History({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${data.block} - ${data.name}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Iuran Bulanan 2023',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'No',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Bulan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Nominal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: data.payments
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
