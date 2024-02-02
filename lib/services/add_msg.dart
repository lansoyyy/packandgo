import 'package:cloud_firestore/cloud_firestore.dart';

Future addMessage(name, msg, driverId, userId) async {
  final docUser = FirebaseFirestore.instance.collection('Message').doc();

  final json = {
    'name': name,
    'msg': msg,
    'userId': userId,
    'driverId': driverId,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
