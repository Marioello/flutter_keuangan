import 'package:flutter/material.dart';
import 'package:flutter_keuangan/models/model.dart';
import 'package:flutter_keuangan/pages/history.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final list = memberData;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('Daftar anggota'),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => History(data: list[index]),
                        ),
                      );
                    },
                    child: Text(list[index].name),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: list.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
