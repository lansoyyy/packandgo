import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addRatings(myname, stars, msg, businessid) async {
  final docUser = FirebaseFirestore.instance.collection('Ratings').doc();

  final json = {
    'myname': myname,
    'stars': stars,
    'msg': msg,
    'id': docUser.id,
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'businessid': businessid,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
