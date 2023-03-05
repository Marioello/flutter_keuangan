import 'package:flutter/material.dart';

class Member {
  String uid;
  String name;
  String blockNo;
  // late List<Payment> payments;

  Member({
    required this.uid,
    required this.name,
    required this.blockNo,
    // required this.payments,
  });
}

class Payment {
  String uid;
  String name;
  String nominal;
  int month;

  Payment({
    required this.uid,
    required this.name,
    required this.nominal,
    required this.month,
  });
}

// final memberData = [
//   Member(
//     uid: UniqueKey().toString(),
//     name: 'Mario',
//     blockNo: 'I1/15',
//     payments: [
//       Payment(
//         uid: UniqueKey().toString(),
//         name: 'Januari',
//         nominal: '50000',
//         month: 1,
//       ),
//       Payment(
//         uid: UniqueKey().toString(),
//         name: 'Februari',
//         nominal: '50000',
//         month: 2,
//       ),
//       Payment(
//         uid: UniqueKey().toString(),
//         name: 'Maret',
//         nominal: '50000',
//         month: 3,
//       ),
//     ],
//   ),
//   Member(
//     uid: UniqueKey().toString(),
//     name: 'Darozi',
//     blockNo: 'I1/16',
//     payments: [],
//   ),
// ];
