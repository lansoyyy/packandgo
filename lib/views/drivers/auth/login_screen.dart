// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:packandgo/services/emailChecker.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/utils/routes.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/custom_widgets.dart';
import 'package:packandgo/widgets/input_field.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../queries/authQuery.dart';
import '../../../../../queries/queries.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});
  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var auth = AuthQuery();
  var userDetailsQuery = Queries();
  bool isLoading = false;
  bool isObscure = true;

  var loggedIn = false;
  var firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    emailController.text = "driver@gmail.com";
    passwordController.text = "password";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? Form(
              key: _form,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    color: primary,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.landingpage);
                            },
                            child: TextBold(
                              text: 'Pack & Go',
                              fontSize: 38,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.driversignuppage);
                            },
                            child: TextRegular(
                              text: 'Signup',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  TextBold(text: 'Login', fontSize: 38, color: Colors.black),
                  SizedBox(height: 30),
                  Container(
                    width: 500,
                    alignment: Alignment.centerLeft,
                    child: labelText(label: "Email"),
                  ),
                  Container(
                    width: 500,
                    child: inputField(
                      controller: emailController,
                      isDense: true,
                      validator: (value) {
                        if (emailController.text.isEmpty) {
                          return "Email is required";
                        } else if (!isValidEmail(emailController.text)) {
                          return "Please enter a valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 500,
                    alignment: Alignment.centerLeft,
                    child: labelText(label: "Password"),
                  ),
                  Container(
                    width: 500,
                    child: inputField(
                      controller: passwordController,
                      isDense: true,
                      isObscureText: isObscure,
                      suffixIcon: Icon(Icons.visibility, size: 18),
                      onSuffixTap: () {
                        setState(() => isObscure = !isObscure);
                      },
                      validator: (value) {
                        if (passwordController.text.isEmpty) {
                          return "Password is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ButtonWidget(
                    radius: 5,
                    color: green,
                    height: 45,
                    width: 500,
                    label: 'Login',
                    onPressed: () async {
                      if (_form.currentState!.validate()) {
                        login(context);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<int> _handleSignIn(String type) async {
    switch (type) {
      case "FB":
        FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
        final accessToken = facebookLoginResult.accessToken!.token;
        if (facebookLoginResult.status == FacebookLoginStatus.success) {
          final facebookAuthCred = FacebookAuthProvider.credential(accessToken);
          final user =
              await firebaseAuth.signInWithCredential(facebookAuthCred);
          print("User : ${user.additionalUserInfo}");
          return 1;
        } else {
          return 0;
        }
      case "G":
        try {
          GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
          final googleAuth = await googleSignInAccount.authentication;
          final googleAuthCred = GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          final user = await firebaseAuth.signInWithCredential(googleAuthCred);
          // print("User : $user");
          if (user.credential!.accessToken != null) {
            showToast('Logged in successfuly!');
            Navigator.pushNamed(context, Routes.driverhomescreen);
          }
          return 1;
        } catch (error) {
          print("some error $error");
          showToast('Something went wrong! $error');
          return 0;
        }
    }
    return 0;
  }

  login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showToast('Logged in succesfully!');
      Navigator.of(context).pushReplacementNamed(Routes.driverhomescreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }

  // Future _handleFBSignIn() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   print("loginResult $loginResult");

  //   // Create a credential from the access token
  //   // final OAuthCredential facebookAuthCredential =
  //   //     FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   // Once signed in, return the UserCredential
  //   // var response =
  //   //     FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //   // print("whats response $response");
  //   // return response;
  // }

  Future _handleFBSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(
        permissions: [
          FacebookPermission.email,
          FacebookPermission.publicProfile
        ]);
    print("facebookLoginResult $facebookLoginResult");
    // switch (facebookLoginResult.status) {
    //   case FacebookLoginStatus.cancelledByUser:
    //     print("Cancelled");
    //     break;
    //   case FacebookLoginStatus.error:
    //     print("error");
    //     break;
    //   case FacebookLoginStatus.loggedIn:
    //     print("Logged In");
    //     break;
    // }
    return facebookLoginResult;
  }

  Future _handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
      clientId:
          "370229023048-9p71ocm86lavkn5bi9u5779e1bi47tvg.apps.googleusercontent.com",
    );
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }
}
