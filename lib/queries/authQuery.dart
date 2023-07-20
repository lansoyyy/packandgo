// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import '../models/userDetailsModel.dart';

class AuthQuery {
  String errorMessage = "";
  UserData? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }

    return UserData(user.uid, user.email);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future signInWithEmailAndPassword({required String email, required String password, required context}) async {
    try {
      var credentials = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      errorMessage = "";
      return {"error": false, "user-data": _userFromFirebase(credentials.user)};
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message.toString();

      return {"error": true, "error-message": errorMessage, "user-data": null};
    } catch (e) {}
  }

  Future<UserData?> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      var credentials = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      errorMessage = "";
      return _userFromFirebase(credentials.user);
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == "email-already-in-use") {
        errorMessage = e.code.toString();
      } else {
        errorMessage = "";
      }

      return null;
    }
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      User _user = result.user!;
      return _user;
    } catch (e) {
      return null;
    }
  }

  Future<void> changePassword(String email, String currentPassword, String newPassword) async {
    try {
      // Sign in the user with their email and current password
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: currentPassword);

      // If sign-in is successful, change the password
      var user = _firebaseAuth.currentUser;
      await user!.updatePassword(newPassword);

      // Password changed successfully
      print('Password changed successfully');
    } catch (e) {
      // Handle error during password change
      print('Error changing password: $e');
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
