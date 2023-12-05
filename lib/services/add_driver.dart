import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addDriver(fname, lname, username, number, email, license, expiredate,
    maker, yearmodel, type, platenumber) async {
  final docUser = FirebaseFirestore.instance
      .collection('Drivers')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'fname': fname,
    'lname': lname,
    'username': username,
    'number': number,
    'email': email,
    'license': license,
    'expiredate': expiredate,
    'maker': maker,
    'yearmodel': yearmodel,
    'type': type,
    'platenumber': platenumber,
    'id': docUser.id,
    'history': [],
    'dateTime': DateTime.now(),
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'isActive': true
  };

  await docUser.set(json);
}
