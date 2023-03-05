import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_keuangan/models/model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference memberCollection =
      FirebaseFirestore.instance.collection('members');
  final CollectionReference paymentCollection =
      FirebaseFirestore.instance.collection('payments');
  // final CollectionReference quizCollection =
  //     FirebaseFirestore.instance.collection('quizzes');

  // // add Payment
  // Future updateGameState(GameState data) async {
  //   return await gameState.doc(uid).set({
  //     'code': data.id,
  //     'name': data.name,
  //   });
  // }

  // // Payment list from snapshot
  // List<GameState> _gameStateSnapshot(QuerySnapshot snapshot) {
  //   try {
  //     return snapshot.docs
  //         .map(
  //           (e) => GameState(
  //             id: e.get('code').toString(),
  //             code: e.id.toString(),
  //             name: e.get('name').toString(),
  //           ),
  //         )
  //         .toList();
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //     return [];
  //   }
  // }

  // Stream<List<GameState>> get states {
  //   return FirebaseFirestore.instance
  //       .collection('states')
  //       .snapshots()
  //       .map(_gameStateSnapshot);
  // }

  // // add Member
  // Future updateMemberData(Member data) async {
  //   return await members.doc().set({
  //     'question': data.question,
  //     'answer': data.answer,
  //     'opt1': data.opt1,
  //     'opt2': data.opt2,
  //     'opt3': data.opt3,
  //     'opt4': data.opt4,
  //   });
  // }

  // Member list from snapshot
  List<Member> _memberListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs
          .map(
            (e) => Member(
              uid: e.id,
              name: e.get('name').toString(),
              blockNo: e.get('blockNo').toString(),
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Stream<List<Member>> get members {
    return memberCollection.snapshots().map(_memberListFromSnapshot);
  }

  // ///

  // // add Payment
  // Future updatePaymentData(Payment data) async {
  //   return await paymentCollection.doc(uid).set({
  //     'title': data.title,
  //   });
  // }

  // Payment list from snapshot
  List<Payment> _paymentListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs
          .map(
            (e) => Payment(
              uid: e.id.toString(),
              name: e.get('name').toString(),
              nominal: e.get('nominal').toString(),
              month: int.parse(e.get('month').toString()),
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Stream<List<Payment>> get payments {
    return FirebaseFirestore.instance
        .collection('members/$uid/payments')
        .snapshots()
        .map(_paymentListFromSnapshot);
  }

  // ///

  // // add Player
  // Future updatePlayerData(Player data) async {
  //   return await FirebaseFirestore.instance
  //       .collection('quizzes/$uid/players')
  //       .doc()
  //       .set({
  //     'name': data.name,
  //   });
  // }

  // // Player list from snapshot
  // List<Player> _playerListFromSnapshot(QuerySnapshot snapshot) {
  //   try {
  //     return snapshot.docs
  //         .map(
  //           (e) => Player(
  //             name: e.get('name').toString(),
  //           ),
  //         )
  //         .toList();
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //     return [];
  //   }
  // }

  // Stream<List<Player>> get players {
  //   // return playerCollection.snapshots().map(_playerListFromSnapshot);
  //   return FirebaseFirestore.instance
  //       .collection('quizzes/$uid/players')
  //       .snapshots()
  //       .map(_playerListFromSnapshot);
  // }

  // // add Payment Answer by id
  // Future updateAnswerById(
  //     String code, String questionNo, String answer, String userName) async {
  //   return await FirebaseFirestore.instance
  //       .collection('quizzes/$uid/answers')
  //       .doc()
  //       .set({
  //     'code': code,
  //     'questionNo': questionNo,
  //     'answer': answer,
  //     'userName': userName,
  //   });
  // }

  // // Player list from snapshot
  // List<Answer> _answerListFromSnapshot(QuerySnapshot snapshot) {
  //   try {
  //     return snapshot.docs
  //         .map(
  //           (e) => Answer(
  //             code: e.get('code').toString(),
  //             questionNo: e.get('questionNo').toString(),
  //             answer: e.get('answer').toString(),
  //             userName: e.get('userName').toString(),
  //           ),
  //         )
  //         .toList();
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //     return [];
  //   }
  // }

  // Stream<List<Answer>> get answers {
  //   String path = 'quizzes/$uid/answers';
  //   return FirebaseFirestore.instance
  //       .collection(path)
  //       .snapshots()
  //       .map(_answerListFromSnapshot);
  // }
}
