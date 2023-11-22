import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addOrder(lat, long, pickup, dropoff, additionalpickup, additionaldropoff,
    dateAndTime, hasLoader, hasRearranger, vehicletype) async {
  final docUser = FirebaseFirestore.instance.collection('Orders').doc();

  final json = {
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
    'uid': FirebaseAuth.instance.currentUser!.uid
  };

  await docUser.set(json);
}
