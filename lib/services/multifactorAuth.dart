// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';

Future<void> verifyPhoneNumber() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) async {
    var result = await _auth.signInWithCredential(phoneAuthCredential);
    print("result $result");
    // Verification completed, proceed to the next screen
    // or perform any necessary actions.
  };

  final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) {
    print('Verification failed: ${authException.message}');
    // Show error message to the user.
  };

  // final PhoneCodeSent codeSent =
  //     (String verificationId, [int? forceResendingToken]) {
  //   setState(() {
  //     _verificationId = verificationId;
  //   });
  // };

  // final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
  //   setState(() {
  //     _verificationId = verificationId;
  //   });
  // };

  // await _auth.verifyPhoneNumber(
  //   phoneNumber: _phoneNumberController.text,
  //   verificationCompleted: verificationCompleted,
  //   verificationFailed: verificationFailed,
  //   codeSent: codeSent,
  //   codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  // );
}
