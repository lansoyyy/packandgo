// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packandgo/services/emailChecker.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/custom_widgets.dart';
import 'package:packandgo/widgets/input_field.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../../queries/queries.dart';
import '../../../../queries/authQuery.dart';
import '../../../../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    emailController.text = "admin@gmail.com";
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
                          TextBold(
                            text: 'Pack & Go',
                            fontSize: 38,
                            color: Colors.white,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.signuppage);
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
                  SizedBox(height: 20),
                  // Container(
                  //   width: 500,
                  //   alignment: Alignment.center,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CustomWidgets.socialButtonRect(
                  //         'Login with Facebook',
                  //         facebookColor,
                  //         FontAwesomeIcons.facebookF,
                  //         onTap: () async {
                  //           await _handleSignIn("FB");
                  //           // Fluttertoast.showToast(msg: 'I am facebook');
                  //         },
                  //       ),
                  //       SizedBox(width: 10),
                  //       CustomWidgets.socialButtonRect(
                  //         'Login with Google',
                  //         googleColor,
                  //         FontAwesomeIcons.googlePlusG,
                  //         onTap: () async {
                  //           await _handleSignIn("G");
                  //           // Fluttertoast.showToast(msg: 'I am google');
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Align(alignment: Alignment.center, child: Text("or")),
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
                        _form.currentState!.save();
                        setState(() => isLoading = true);
                        var response = await auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                        );
                        if (!response['error']) {
                          await userDetailsQuery.getUserData(response['user-data'].uid);
                          showToast('Logged in successfuly!');
                          Navigator.pushNamed(context, Routes.homepage);
                        } else {
                          showToast(
                            response['error-message'],
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                        setState(() => isLoading = false);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: TextRegular(
                      text: 'Forgot Password',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<int> _handleSignIn(String type) async {
    switch (type) {
      case "FB":
        // FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
        // final accessToken = facebookLoginResult.accessToken!.token;
        // if (facebookLoginResult.status == FacebookLoginStatus.success) {
        //   final facebookAuthCred = FacebookAuthProvider.credential(accessToken);
        //   final user = await firebaseAuth.signInWithCredential(facebookAuthCred);
        //   print("User : ${user.additionalUserInfo}");
        //   return 1;
        // } else {
        //   return 0;
        // }
        // var result = await FacebookAuth.instance.webAndDesktopInitialize(
        //   appId: "1329834907365798",
        //   cookie: true,
        //   xfbml: true,
        //   version: "v15.0",
        // );
        break;
      case "G":
        try {
          GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
          final googleAuth = await googleSignInAccount.authentication;
          final googleAuthCred = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          final user = await firebaseAuth.signInWithCredential(googleAuthCred);
          // print("User : $user");
          if (user.credential!.accessToken != null) {
            showToast('Logged in successfuly!');
            Navigator.pushNamed(context, Routes.homepage);
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
    FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(permissions: [FacebookPermission.email, FacebookPermission.publicProfile]);
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
      clientId: "370229023048-9p71ocm86lavkn5bi9u5779e1bi47tvg.apps.googleusercontent.com",
    );
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }
}
