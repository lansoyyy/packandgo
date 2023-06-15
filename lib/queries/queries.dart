import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Queries {
  String id = "";
  final db = FirebaseFirestore.instance;

  Future push(root, data) async {
    var ref = await db.collection(root).add(data);
    id = ref.id;
    print("ref response $ref");
    return ref.id.toString();
  }

  Future getUserData(uid) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    CollectionReference users = db.collection('user-details');
    QuerySnapshot userDetails = await users.where('uid', isEqualTo: uid).get();
    // print("userDetails ${userDetails.docs}");
    var user;
    userDetails.docs.forEach((element) {
      // print("printing${element.data()}");
      user = element.data();
    });
    if (user != null) {
      await userData.setString('userDetails', json.encode(user));
    }
    // await userData.setString('userDetails', json.encode(userDetails.docs.toSet()));
    return userDetails;
  }

  Future<bool> update(root, id, data) async {
    await db.collection(root).doc(id).update(data).whenComplete(() => null);
    return true;
  }

  Future<bool> deleteByID(root, key) async {
    await db.collection(root).doc(key).delete();
    return true;
  }
}
