import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:packandgo/queries/authQuery.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/textfield_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../queries/queries.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/text_widget.dart';
import 'auth/login_screen.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool profiletab = true;
  bool changepasswordtab = false;
  bool isLoading = false;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  bool passwordVerified = false;
  var userDetails;

  getUserData() async {
    setState(() => isLoading = true);
    final SharedPreferences userData = await SharedPreferences.getInstance();
    var details = userData.getString('userDetails');
    userDetails = details != null ? json.decode(details) : null;
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: !isLoading
          ? Column(
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
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.recordspage);
                              },
                              child: TextRegular(
                                text: 'Records',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            PopupMenuButton(
                              iconSize: 150,
                              icon: TextRegular(
                                text: 'John',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    onTap: () {},
                                    child: TextRegular(
                                      text: 'My Account',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                  'Logout Confirmation',
                                                  style: TextStyle(
                                                      fontFamily: 'QBold',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: const Text(
                                                  'Are you sure you want to Logout?',
                                                  style: TextStyle(
                                                      fontFamily: 'QRegular'),
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text(
                                                      'Close',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'QRegular',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LoginScreen()));
                                                    },
                                                    child: const Text(
                                                      'Continue',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'QRegular',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                  'Logout Confirmation',
                                                  style: TextStyle(
                                                      fontFamily: 'QBold',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: const Text(
                                                  'Are you sure you want to Logout?',
                                                  style: TextStyle(
                                                      fontFamily: 'QRegular'),
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text(
                                                      'Close',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'QRegular',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LoginScreen()));
                                                    },
                                                    child: const Text(
                                                      'Continue',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'QRegular',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    },
                                    child: TextRegular(
                                      text: 'Logout',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/profile.png',
                                height: 75,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextBold(
                                    text:
                                        '${userDetails['firstname']} ${userDetails['lastname']}',
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                  TextRegular(
                                      text: 'Edit Profile',
                                      fontSize: 16,
                                      color: Colors.grey),
                                  TextRegular(
                                      text: 'Change picture',
                                      fontSize: 16,
                                      color: Colors.grey),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(width: 100, child: Divider()),
                          const SizedBox(
                            height: 10,
                          ),
                          TextBold(
                            text: 'My Account',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                profiletab = true;
                                changepasswordtab = false;
                              });
                            },
                            child: TextRegular(
                                text: 'Profile',
                                fontSize: 12,
                                color: profiletab ? Colors.amber : Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                profiletab = false;
                                changepasswordtab = true;
                              });
                            },
                            child: TextRegular(
                                text: 'Change Password',
                                fontSize: 12,
                                color: changepasswordtab
                                    ? Colors.amber
                                    : Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(height: 500, child: VerticalDivider()),
                      const SizedBox(
                        width: 10,
                      ),
                      profiletab
                          ? profileTab(userDetails)
                          : changepasswordTab(userDetails),
                    ],
                  ),
                ),
              ],
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget profileTab(details) {
    emailController.text = "${details['email'] ?? ''}";
    phoneController.text = "${details['contact_number'] ?? ''}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextRegular(
          text: 'My Profile',
          fontSize: 32,
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        TextRegular(
            text: 'Manage and secure your account',
            fontSize: 14,
            color: Colors.grey),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(width: 300, child: Divider()),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Username:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            TextRegular(
              text: "${details['username'] ?? 'Username'}",
              fontSize: 18,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Name:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            TextRegular(
              text:
                  "${details['firstname'] ?? ''} ${details['lastname'] ?? ''}",
              fontSize: 18,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Email:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 150,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'doe123@gmail.com',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Phone Number:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 150,
              child: TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: '09090104355',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Gender:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            TextRegular(
              text: "${details['gender'] ?? ''}",
              fontSize: 18,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Date of Birth:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            TextRegular(
              text: "${details['birthday'] ?? ''}",
              fontSize: 18,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ButtonWidget(
          radius: 5,
          color: primary,
          fontSize: 14,
          width: 150,
          label: 'Save',
          onPressed: () async {
            var query = Queries();
            await query.update(
              'user-details',
              details["id"],
              {
                'email': emailController.text,
                'contact_number': phoneController.text,
              },
            );
          },
        ),
      ],
    );
  }

  Widget changepasswordTab(details) {
    return passwordVerified
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextRegular(
                text: 'Security Check',
                fontSize: 32,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Manage and secure your account',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(width: 300, child: Divider()),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.security_outlined,
                      size: 75,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                      text: 'Verification complete!',
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                    TextRegular(
                      text:
                          'For your account security, do not share your password with anyone else.',
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        isObscure: true,
                        isPassword: true,
                        label: 'Password',
                        controller: passwordController),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        isObscure: true,
                        isPassword: true,
                        label: 'Confirm Password',
                        controller: confirmpasswordController),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ButtonWidget(
                        radius: 5,
                        color: primary,
                        fontSize: 14,
                        width: 150,
                        label: 'Confirm',
                        onPressed: () async {
                          var authQuery = AuthQuery();
                          await authQuery.changePassword(
                              details['email'],
                              passwordController.text,
                              confirmpasswordController.text);
                          setState(() {
                            profiletab = true;
                            changepasswordtab = false;
                          });
                          showToast('Password changed succesfully!');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextRegular(
                text: 'Security Check',
                fontSize: 32,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Manage and secure your account',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(width: 300, child: Divider()),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.security_outlined,
                      size: 75,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                      text: 'To protect your account, verify your account',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    TextRegular(
                      text: ' and change your password.',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ButtonWidget(
                  radius: 5,
                  color: primary,
                  fontSize: 14,
                  width: 150,
                  label: 'Change Password',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: TextBold(
                              text: 'Enter your current password',
                              fontSize: 18,
                              color: Colors.black),
                          content: SizedBox(
                            height: 75,
                            child: TextFieldWidget(
                                isObscure: true,
                                isPassword: true,
                                label: 'Password',
                                controller: passwordController),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                setState(() {
                                  passwordVerified = true;
                                });
                                Navigator.pop(context);
                              },
                              child: TextBold(
                                text: 'Continue',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
  }
}
