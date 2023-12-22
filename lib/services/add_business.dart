import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addBusiness(fname, lname, username, number, email, address) async {
  final docUser = FirebaseFirestore.instance
      .collection('Business')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'fname': fname,
    'lname': lname,
    'username': username,
    'number': number,
    'email': email,
    'id': docUser.id,
    'history': [],
    'dateTime': DateTime.now(),
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'address': address
  };

  await docUser.set(json);
}
