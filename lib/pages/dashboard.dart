import 'package:flutter/material.dart';
import 'package:flutter_keuangan/helper.dart';
import 'package:provider/provider.dart';

import '../models/arguments.dart';
import '../models/model.dart';
import 'history.dart';

class Dashboard extends StatelessWidget {
  static const String route = '/';
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<List<Member>>(context);
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: textHelper('Daftar Anggota', 20, '400', color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text(list[index].name.substring(0, 1)),
                          ),
                          title: Text(list[index].name),
                          subtitle: const Text('Nomor telepon'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              History.route,
                              arguments: HistoryArguments(
                                list[index].uid,
                                list[index].name,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 0.0, 10.0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textHelper('Lihat riwayat pembayaran', 14, '',
                                    color: Colors.blue),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15.0,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.pushNamed(
                        //       context,
                        //       History.route,
                        //       arguments: HistoryArguments(
                        //         list[index].uid,
                        //         list[index].name,
                        //       ),
                        //     );
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //     builder: (context) => MultiProvider(
                        //     //       providers: [
                        //     //         StreamProvider<List<Payment>>.value(
                        //     //           initialData: const [],
                        //     //           value: DatabaseService(uid: list[index].uid)
                        //     //               .payments,
                        //     //         ),
                        //     //       ],
                        //     //       child: History(
                        //     //           uid: list[index].uid, data: list[index]),
                        //     //     ),
                        //     //   ),
                        //     // );
                        //   },
                        //   child: Text(list[index].name),
                        // )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
