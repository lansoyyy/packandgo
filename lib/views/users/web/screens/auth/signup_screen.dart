// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:packandgo/services/add_user.dart';
import 'package:packandgo/services/emailChecker.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';

import '../../../../../queries/authQuery.dart';
import '../../../../../queries/queries.dart';
import '../../../../../utils/routes.dart';
import '../../../../../widgets/button_widget.dart';
import '../../../../../widgets/custom_widgets.dart';
import '../../../../../widgets/input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final genderController = TextEditingController();
  final birthdayController = TextEditingController();
  final contactnumberController = TextEditingController();

  bool check1 = true;
  bool check2 = false;
  bool check3 = false;
  bool isLoading = false;
  bool isObscure = true;
  final bool _onEditing = false;

  final _form = GlobalKey<FormState>();
  var auth = AuthQuery();
  var userDetailsQuery = Queries();
  final int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  final _code = "";
  var credential;
  var codeVerificationId;

  @override
  void initState() {
    firstnameController.text = "Jhon";
    lastnameController.text = "Doe";
    contactnumberController.text = "3894756354";
    emailController.text = "admin@gmail.com";
    passwordController.text = "password";
    usernameController.text = 'Doe123';
    genderController.text = 'Male';
    birthdayController.text = 'November 15, 2023';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? SingleChildScrollView(
              child: Form(
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
                                Navigator.pushNamed(
                                    context, Routes.landingpage);
                              },
                              child: TextBold(
                                text: 'Pack & Go',
                                fontSize: 38,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.loginpage);
                              },
                              child: TextRegular(
                                text: 'Login',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      height: 1000,
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: TextBold(
                              text: 'Signup',
                              fontSize: 38,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          if (_currentStep == 0)
                            Wrap(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: check1,
                                      onChanged: (value) {
                                        setState(() {
                                          check1 = !check1;
                                          check2 = false;
                                          check3 = false;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 300,
                                      child: Text(
                                        'New Customer',
                                        style:
                                            TextStyle(fontFamily: 'QRegular'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                labelText(label: "First Name"),
                                inputField(
                                  controller: firstnameController,
                                  isDense: true,
                                  validator: (value) {
                                    if (firstnameController.text.isEmpty) {
                                      return "  This field is required!";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                labelText(label: "Last Name"),
                                inputField(
                                  controller: lastnameController,
                                  isDense: true,
                                  validator: (value) {
                                    if (lastnameController.text.isEmpty) {
                                      return "  This field is required!";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                labelText(label: "User Name"),
                                inputField(
                                  controller: usernameController,
                                  isDense: true,
                                  validator: (value) {
                                    if (usernameController.text.isEmpty) {
                                      return "  This field is required!";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                labelText(label: "Contact Number"),
                                inputField(
                                  controller: contactnumberController,
                                  isDense: true,
                                  validator: (value) {
                                    if (contactnumberController.text.isEmpty) {
                                      return "  This field is required!";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                labelText(label: "Gender"),
                                inputField(
                                  controller: genderController,
                                  isDense: true,
                                  validator: (value) {
                                    if (genderController.text.isEmpty) {
                                      return "  This field is required!";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                labelText(label: "Date of Birth"),
                                inputField(
                                  controller: birthdayController,
                                  isDense: true,
                                  validator: (value) {
                                    if (birthdayController.text.isEmpty) {
                                      return "  This field is required!";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                labelText(label: "Email"),
                                inputField(
                                  controller: emailController,
                                  isDense: true,
                                  validator: (value) {
                                    if (emailController.text.isEmpty) {
                                      return "Email is required";
                                    } else if (!isValidEmail(
                                        emailController.text)) {
                                      return "Please enter a valid email";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                labelText(label: "Password"),
                                inputField(
                                  controller: passwordController,
                                  isDense: true,
                                  isObscureText: isObscure,
                                  suffixIcon: Icon(Icons.visibility, size: 18),
                                  onSuffixTap: () {
                                    setState(() => isObscure = !isObscure);
                                  },
                                  validator: (value) {
                                    if (passwordController.text.isEmpty) {
                                      return "  This field is required!";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                          ButtonWidget(
                            radius: 5,
                            color: green,
                            height: 45,
                            width: 500,
                            label: 'Continue',
                            onPressed: () async {
                              if (_form.currentState!.validate()) {
                                register(context);
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          if (_currentStep == 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextRegular(
                                  text: 'Already have an account?',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.loginpage);
                                  },
                                  child: TextBold(
                                    text: 'Login',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      addUser(
          firstnameController.text,
          lastnameController.text,
          usernameController.text,
          contactnumberController.text,
          genderController.text,
          birthdayController.text,
          emailController.text,
          'User');

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      showToast('Account created succesfully!');
      Navigator.of(context).pushReplacementNamed(Routes.homepage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
