import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(
    fname, lname, username, number, gender, dateofbirth, email, type) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'fname': fname,
    'lname': lname,
    'username': username,
    'number': number,
    'gender': gender,
    'dateofbirth': dateofbirth,
    'email': email,
    'id': docUser.id,
    'history': [],
    'dateTime': DateTime.now(),
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'type': type
  };

  await docUser.set(json);
}
