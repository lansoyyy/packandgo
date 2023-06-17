// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:packandgo/services/emailChecker.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';

import '../../../../queries/queries.dart';
import '../../../../queries/streamQuery.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/button_widget.dart';
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
  final contactnumberController = TextEditingController();

  bool check1 = true;
  bool check2 = false;
  bool check3 = false;
  bool isLoading = false;

  final _form = GlobalKey<FormState>();
  var auth = AuthQuery();
  var userDetailsQuery = Queries();

  @override
  void initState() {
    firstnameController.text = "Jhon";
    lastnameController.text = "Doe";
    contactnumberController.text = "3894756354";
    emailController.text = "admin@gmail.com";
    passwordController.text = "password";
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
                              const Expanded(
                                child: SizedBox(),
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
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 1000,
                        width: 500,
                        child: Column(
                          children: [
                            TextBold(
                              text: 'Signup',
                              fontSize: 38,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                            TextFieldWidget(
                              width: 500,
                              label: 'First Name',
                              controller: firstnameController,
                              // validator: (value) {
                              //   return firstnameController.text.isEmpty
                              //       ? "This field is required"
                              //       : null;
                              // },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              width: 500,
                              label: 'Last Name',
                              controller: lastnameController,
                              // validator: (value) {
                              //   return lastnameController.text.isEmpty
                              //       ? "This field is required"
                              //       : null;
                              // },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              inputType: TextInputType.number,
                              width: 500,
                              label: 'Contact Number',
                              controller: contactnumberController,
                              // validator: (value) {
                              //   return contactnumberController.text.isEmpty
                              //       ? "This field is required"
                              //       : null;
                              // },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              width: 500,
                              label: 'Email',
                              controller: emailController,
                              // validator: (value) {
                              //   if (emailController.text.isEmpty) {
                              //     return "This field is required";
                              //   } else if (isValidEmail(emailController.text)) {
                              //     return "Please enter a valid email";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              isObscure: true,
                              isPassword: true,
                              width: 500,
                              label: 'Password',
                              controller: passwordController,
                              // validator: (value) {
                              //   return passwordController.text.isEmpty
                              //       ? "This field is required"
                              //       : null;
                              // },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonWidget(
                              radius: 5,
                              color: Colors.green[500],
                              height: 45,
                              width: 500,
                              label: 'Signup',
                              onPressed: () async {
                                print(
                                    "firstname: ${firstnameController.text} \nlastname: ${lastnameController.text} \ncontact number :${contactnumberController.text} \nemail: ${emailController.text} \npassword: ${passwordController.text}");

                                if (_form.currentState!.validate()) {
                                  _form.currentState!.save();
                                  setState(() => isLoading = true);
                                  // var userDetailsAPI = Queries();
                                  var response = await auth.signUpWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  if (response != null) {
                                    var userDetailsData = {
                                      "uid": response.uid,
                                      "firstname": firstnameController.text,
                                      "lastname": lastnameController.text,
                                      "email": emailController.text,
                                      "contact_number": contactnumberController.text,
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

                                    showToast('Account created successfuly!');
                                    Navigator.pushNamed(context, Routes.loginpage);
                                  } else {
                                    showToast('Email already used!');
                                  }

                                  setState(() => isLoading = false);
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
}
