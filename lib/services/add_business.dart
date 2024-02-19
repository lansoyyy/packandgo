import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addBusiness(
    fname,
    lname,
    username,
    number,
    email,
    address,
    businessname,
    permitnumber,
    dtinumber,
    tourismnumber,
    contactperson,
    contactnumber) async {
  final docUser = FirebaseFirestore.instance
      .collection('Business')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'businessname': businessname,
    'fname': fname,
    'lname': lname,
    'username': username,
    'number': number,
    'email': email,
    'id': docUser.id,
    'history': [],
    'dateTime': DateTime.now(),
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'address': address,
    'usersRated': [],
    'plan': {},
    'permitnumber': permitnumber,
    'dtinumber': dtinumber,
    'tourismnumber': tourismnumber,
    'contactperson': contactperson,
    'contactnumber': contactnumber,
  };

  await docUser.set(json);
}
