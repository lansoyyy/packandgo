// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packandgo/services/add_driver.dart';
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

class DriverSignupScreen extends StatefulWidget {
  const DriverSignupScreen({super.key});

  @override
  State<DriverSignupScreen> createState() => _DriverSignupScreenState();
}

class _DriverSignupScreenState extends State<DriverSignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final contactnumberController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final expirationDateController = TextEditingController();
  final makerController = TextEditingController();
  final yearModelController = TextEditingController();
  final plateNumberController = TextEditingController();
  final usernameController = TextEditingController();

  bool check2 = true;

  bool hasHelper = true;

  bool isLoading = false;
  bool isObscure = true;
  final bool _onEditing = false;

  final _form = GlobalKey<FormState>();
  var auth = AuthQuery();
  var userDetailsQuery = Queries();
  final int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  var _code = "";
  var credential;
  var codeVerificationId;

  List<Map<String, String>> vehicles = [
    {"name": "Motorcycle", "image": "motorcycle.png"},
    {
      "name": "500 Kg Jeepney (Standard Type)",
      "image": "500-kg-Jeepney-(Standard-Type).png"
    },
    {
      "name": "800 Kg Jeepney (Lawin Type)",
      "image": "800-kg-Jeepney-(Lawin-Type).png"
    },
    {"name": "300 Kg Taxi Sedan", "image": "300-Kg-Taxi.png"},
    {"name": "500 Kg Taxi MPV", "image": "500-Kg-Taxi-MPV.png"},
    {
      "name": "6-Wheel Truck Close Type",
      "image": "6-Wheel-Truck-Close-Type.png"
    },
    {
      "name": "10-Wheel Truck Close Type",
      "image": "10-Wheel-Truck-Close-Type.png"
    },
    {"name": "6-Wheel Truck Open Type", "image": "6-Wheel-Truck-Open-Type.png"},
    {
      "name": "10-Wheel Truck Open Type",
      "image": "10-Wheel-Truck-Open-Type.png"
    },
  ];

  String selectedVehicle = '';
  int dropValue = 0;

  String imgUrl = '';

  String imgUrl2 = '';

  @override
  void initState() {
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
                                  Navigator.pushNamed(
                                      context, Routes.driverloginpage);
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
                        child: SingleChildScrollView(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: check2,
                                          onChanged: (value) {},
                                        ),
                                        const SizedBox(
                                          width: 300,
                                          child: Text(
                                            'PUJ/Jeepney Operator',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
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
                                        if (firstnameController.text.isEmpty) {
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
                                        if (contactnumberController
                                            .text.isEmpty) {
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
                                      suffixIcon:
                                          Icon(Icons.visibility, size: 18),
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
                                    labelText(label: "Driver License Number"),
                                    inputField(
                                      controller: licenseNumberController,
                                      isDense: true,
                                      validator: (value) {
                                        if (licenseNumberController
                                            .text.isEmpty) {
                                          return "  This field is required!";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    labelText(label: "Expiration Date"),
                                    inputField(
                                      controller: expirationDateController,
                                      isDense: true,
                                      validator: (value) {
                                        if (expirationDateController
                                            .text.isEmpty) {
                                          return "  This field is required!";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: TextBold(
                                          text: 'Vehicle Information',
                                          fontSize: 32,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    labelText(label: "Maker"),
                                    inputField(
                                      controller: makerController,
                                      isDense: true,
                                      validator: (value) {
                                        if (makerController.text.isEmpty) {
                                          return "  This field is required!";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    labelText(label: "Year Model"),
                                    inputField(
                                      controller: yearModelController,
                                      isDense: true,
                                      validator: (value) {
                                        if (yearModelController.text.isEmpty) {
                                          return "  This field is required!";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextRegular(
                                            text: 'Vehicle Type',
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 500,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: DropdownButton(
                                                underline: const SizedBox(),
                                                value: dropValue,
                                                items: [
                                                  for (int i = 0;
                                                      i < vehicles.length;
                                                      i++)
                                                    DropdownMenuItem(
                                                      value: i,
                                                      onTap: () {
                                                        setState(() {
                                                          selectedVehicle =
                                                              vehicles[i]
                                                                  ['name']!;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: TextRegular(
                                                          text:
                                                              '${vehicles[i]['name']}',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    dropValue = int.parse(
                                                        value.toString());
                                                  });
                                                }),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          selectedVehicle ==
                                                      '500 Kg Jeepney (Standard Type)' ||
                                                  selectedVehicle ==
                                                      '800 Kg Jeepney (Lawin Type)'
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                      value: hasHelper,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          hasHelper =
                                                              !hasHelper;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 300,
                                                      child: Text(
                                                        'has helper',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'QRegular'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                    labelText(label: "Plate Number"),
                                    inputField(
                                      controller: plateNumberController,
                                      isDense: true,
                                      validator: (value) {
                                        if (plateNumberController
                                            .text.isEmpty) {
                                          return "  This field is required!";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonWidget(
                                    height: 40,
                                    radius: 10,
                                    width: 125,
                                    fontSize: 10,
                                    textColor: Colors.black,
                                    color: Colors.grey[300],
                                    label: 'UPLOAD ID PICTURE (FRONT)',
                                    onPressed: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child(DateTime.now().toString())
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          setState(
                                            () {
                                              imgUrl = downloadUrl;
                                            },
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Photo Updated Succesfully!',
                                                      fontSize: 14,
                                                      color: Colors.white)));
                                        });
                                      });
                                    },
                                  ),
                                  ButtonWidget(
                                    height: 40,
                                    radius: 10,
                                    width: 125,
                                    fontSize: 10,
                                    textColor: Colors.black,
                                    color: Colors.grey[300],
                                    label: 'UPLOAD ID PICTURE (BACK)',
                                    onPressed: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child(DateTime.now().toString())
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          setState(
                                            () {
                                              imgUrl2 = downloadUrl;
                                            },
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Photo Updated Succesfully!',
                                                      fontSize: 14,
                                                      color: Colors.white)));
                                        });
                                      });
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
                                  if (imgUrl == '' && imgUrl2 == '') {
                                    showToast(
                                        'Registration cannot proceed! Please upload an image of your drivers license');
                                  } else {
                                    if (_form.currentState!.validate()) {
                                      register(context);
                                    }
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
                                            context, Routes.driverloginpage);
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

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // addUser(
      //     firstnameController.text,
      //     lastnameController.text,
      //     usernameController.text,
      //     contactnumberController.text,
      //     genderController.text,
      //     birthdayController.text,
      //     emailController.text,
      //     'User');

      addDriver(
          firstnameController.text,
          lastnameController.text,
          usernameController.text,
          contactnumberController.text,
          emailController.text,
          licenseNumberController.text,
          expirationDateController.text,
          makerController.text,
          yearModelController.text,
          selectedVehicle,
          plateNumberController.text,
          imgUrl,
          imgUrl2);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      showToast('Account created succesfully!');
      Navigator.of(context).pushReplacementNamed(Routes.driverhomescreen);
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

  Future<bool> twoStepAuth(action) async {
    var auth = FirebaseAuth.instance;
    switch (action) {
      case 'send':
        try {
          await auth.verifyPhoneNumber(
            phoneNumber: '+63${(contactnumberController.text).substring(1)}',
            verificationCompleted: (response) {
              print("completed $response");
            },
            verificationFailed: (response) {
              print("failed $response");
              throw FirebaseAuthException(
                code: "verification_failed",
                message: "Phone number verification failed",
              );
            },
            codeSent: (String verificationId, int? resendToken) async {
              codeVerificationId = verificationId;
              print('verification id $verificationId');
              print('resendToken $resendToken');
              setState(() {});
            },
            timeout: const Duration(minutes: 5),
            codeAutoRetrievalTimeout: (response) {
              print("retrival timeout $response");
              showToast("Code expired");
            },
          );
          return true;
        } on FirebaseAuthException catch (e, _) {
          showToast(e.message, toastLength: Toast.LENGTH_LONG);
          return false;
        }

      case 'verify':
        if (codeVerificationId != null && _code != "") {
          String smsCode = _code;
          print("see code: $_code");
          credential = PhoneAuthProvider.credential(
              verificationId: codeVerificationId, smsCode: smsCode);
          try {
            var result = await auth.signInWithCredential(credential);
            _code = "";
            codeVerificationId = null;
            print('see result $result');
            setState(() {});
            return true;
          } on FirebaseAuthException catch (e, _) {
            print("see error ${e.code}");
            if (e.code == 'invalid-phone-number') {
              showToast('The provided phone number is not valid.');
            } else if (e.code == 'invalid-verification-code') {
              showToast("Verification code is invalid");
            } else {
              print("omething wend wrong ${e.message}");
              showToast("something wend wrong ${e.message}");
            }
            return false;
          }
        } else {
          showToast('Insuficient code crredentials');
          return false;
        }
      default:
        return false;
    }
  }
}
