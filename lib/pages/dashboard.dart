import 'package:flutter/material.dart';
import 'package:flutter_keuangan/models/model.dart';
import 'package:flutter_keuangan/pages/history.dart';
import 'package:flutter_keuangan/services/database.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  static const String route = '/';
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<List<Member>>(context);
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
                      Navigator.pushNamed(
                        context,
                        History.route,
                        arguments: {
                          'uid': list[index].uid,
                          'name': list[index].name,
                        },
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MultiProvider(
                      //       providers: [
                      //         StreamProvider<List<Payment>>.value(
                      //           initialData: const [],
                      //           value: DatabaseService(uid: list[index].uid)
                      //               .payments,
                      //         ),
                      //       ],
                      //       child: History(
                      //           uid: list[index].uid, data: list[index]),
                      //     ),
                      //   ),
                      // );
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
