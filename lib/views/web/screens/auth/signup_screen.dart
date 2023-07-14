// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:packandgo/services/emailChecker.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../../../queries/queries.dart';
import '../../../../queries/authQuery.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/custom_widgets.dart';
import '../../../../widgets/input_field.dart';
import '../../../../widgets/textfield_widget.dart';

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
  bool _onEditing = false;

  final _form = GlobalKey<FormState>();
  var auth = AuthQuery();
  var userDetailsQuery = Queries();
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  var _code = "";

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
                              TextBold(
                                text: 'Pack & Go',
                                fontSize: 38,
                                color: Colors.white,
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
                                          style: TextStyle(fontFamily: 'QRegular'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: check2,
                                        onChanged: (value) {
                                          setState(() {
                                            check2 = !check2;
                                            check1 = false;
                                            check3 = false;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 300,
                                        child: Text(
                                          'PUJ/Jeepney Operator',
                                          style: TextStyle(fontFamily: 'QRegular'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: check3,
                                        onChanged: (value) {
                                          setState(() {
                                            check3 = !check3;
                                            check1 = false;
                                            check2 = false;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 300,
                                        child: Text(
                                          'Moving Service Business Owner',
                                          style: TextStyle(fontFamily: 'QRegular'),
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
                                      } else if (!isValidEmail(emailController.text)) {
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
                            if (_currentStep == 1)
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    'Two Step Authentication',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Text("Kindly enter your phone number and we will send you a security code."),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: labelText(label: "Contact Number"),
                                  ),
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
                                ],
                              ),
                            if (_currentStep == 2)
                              Container(
                                alignment: Alignment.center,
                                width: 500,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  children: [
                                    Icon(Icons.task_alt, size: 50),
                                    SizedBox(height: 20),
                                    Text(
                                      'ENTER SECURITY CODE',
                                    ),
                                    SizedBox(height: 20),
                                    Text("Enter the code that was sent to (+63) ${contactnumberController.text}"),
                                    SizedBox(height: 20),
                                    VerificationCode(
                                      textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
                                      keyboardType: TextInputType.number,
                                      underlineColor: Colors.amber,
                                      length: 4,
                                      cursorColor: Colors.blue,
                                      clearAll: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'clear all',
                                          style: TextStyle(fontSize: 14.0, color: Colors.blue[700]),
                                        ),
                                      ),
                                      onCompleted: (String value) {
                                        setState(() {
                                          _code = value;
                                        });
                                      },
                                      onEditing: (bool value) {
                                        setState(() {
                                          _onEditing = value;
                                        });
                                        if (!_onEditing) FocusScope.of(context).unfocus();
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Send another code",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            const SizedBox(height: 20),
                            ButtonWidget(
                              radius: 5,
                              color: green,
                              height: 45,
                              width: 500,
                              label: _currentStep == 2 ? "Verify" : 'Continue',
                              onPressed: () async {
                                if (_form.currentState!.validate()) {
                                  _form.currentState!.save();
                                  setState(() => isLoading = true);
                                  // var userDetailsAPI = Queries();
                                  switch (_currentStep) {
                                    case 0:
                                      var response = await auth.signUpWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                      if (response != null) {
                                        var userDetailsData = {
                                          "uid": response.uid,
                                          "firstname": firstnameController.text,
                                          "lastname": lastnameController.text,
                                          "username": usernameController.text,
                                          "email": emailController.text,
                                          "contact_number": contactnumberController.text,
                                          "gender": genderController.text,
                                          "birthday": birthdayController.text,
                                          "user_type": check1
                                              ? "customer"
                                              : check2
                                                  ? "operator"
                                                  : check3
                                                      ? "owner"
                                                      : "customer",
                                          "status": true
                                        };

                                        await userDetailsQuery.push("user-details", userDetailsData);

                                        _currentStep += 1;
                                      } else {
                                        showToast('Email already used!');
                                      }
                                      break;
                                    case 1:
                                      twoStepAuth();
                                      _currentStep += 1;

                                      break;
                                    case 2:
                                      showToast('Account created successfuly!');
                                      Navigator.pushNamed(context, Routes.loginpage);
                                      _currentStep += 1;
                                      break;
                                    default:
                                  }

                                  setState(() => isLoading = false);
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
                                      Navigator.pushNamed(context, Routes.loginpage);
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
            : const Center(child: CircularProgressIndicator()));
  }

  twoStepAuth() async {
    var result = await FirebaseAuth.instance.verifyPhoneNumber(
      // multiFactorSession: session,
      phoneNumber: '+639657188624',
      verificationCompleted: (response) {
        print("completed $response");
      },
      verificationFailed: (response) {
        print("failed $response");
      },
      codeSent: (String verificationId, int? resendToken) async {
        print('verification id $verificationId');
        print('resendToken $resendToken');
      },
      codeAutoRetrievalTimeout: (_) {},
    );
    // print("result $result");
  }
}
