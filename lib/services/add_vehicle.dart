import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addVehicles(type, maker, yearmodel, platenumber) async {
  final docUser = FirebaseFirestore.instance.collection('Vehicles').doc();

  final json = {
    'type': type,
    'maker': maker,
    'yearmodel': yearmodel,
    'platenumber': platenumber,
    'id': docUser.id,
    'uid': FirebaseAuth.instance.currentUser!.uid
  };

  await docUser.set(json);
}
