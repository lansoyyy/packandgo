import 'package:cloud_firestore/cloud_firestore.dart';

Future addMessage(name, msg, driverId, userId, recordId) async {
  final docUser = FirebaseFirestore.instance.collection('Message').doc();

  final json = {
    'name': name,
    'msg': msg,
    'userId': userId,
    'driverId': driverId,
    'dateTime': DateTime.now(),
    'recordId': recordId,
  };

  await docUser.set(json);
}
