import 'package:flutter/material.dart';

class Member {
  String uid;
  String name;
  String block;
  late List<Payment> payments;

  Member({
    required this.uid,
    required this.name,
    required this.block,
    required this.payments,
  });
}

class Payment {
  String uid;
  String name;
  String nominal;

  Payment({
    required this.uid,
    required this.name,
    required this.nominal,
  });
}

final memberData = [
  Member(
    uid: UniqueKey().toString(),
    name: 'Mario',
    block: 'I1/15',
    payments: [
      Payment(
        uid: UniqueKey().toString(),
        name: 'Januari',
        nominal: '50000',
      ),
      Payment(
        uid: UniqueKey().toString(),
        name: 'Februari',
        nominal: '50000',
      ),
    ],
  ),
  Member(
    uid: UniqueKey().toString(),
    name: 'Darozi',
    block: 'I1/16',
    payments: [],
  ),
];
