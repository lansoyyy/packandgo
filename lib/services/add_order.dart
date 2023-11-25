import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addOrder(
    lat,
    long,
    pickup,
    dropoff,
    additionalpickup,
    additionaldropoff,
    dateAndTime,
    hasLoader,
    hasRearranger,
    vehicletype,
    number,
    altnumber,
    email,
    drivername,
    driverid,
    businessname,
    businessid,
    myname) async {
  final docUser = FirebaseFirestore.instance.collection('Orders').doc();

  final json = {
    'number': number,
    'altnumber': altnumber,
    'email': email,
    'lat': lat,
    'long': long,
    'pickup': pickup,
    'dropoff': dropoff,
    'additionalpickup': additionalpickup,
    'additionaldropoff': additionaldropoff,
    'dateAndTime': dateAndTime,
    'hasLoader': hasLoader,
    'vehicletype': vehicletype,
    'hasRearranger': hasRearranger,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'status': 'Pending',
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'drivername': drivername,
    'driverid': driverid,
    'businessname': businessname,
    'businessid': businessid,
    'myname': myname
  };

  await docUser.set(json);
}
