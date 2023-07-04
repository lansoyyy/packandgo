import 'package:flutter/material.dart';
import 'package:packandgo/widgets/button_widget.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../widgets/text_widget.dart';
import 'auth/login_screen.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool profiletab = true;

  bool changepasswordtab = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                          Navigator.pushNamed(context, Routes.recordspage);
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
                                                fontWeight: FontWeight.bold),
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
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginScreen()));
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
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
                                                fontWeight: FontWeight.bold),
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
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginScreen()));
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
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
                              text: 'John Doe',
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
                          color:
                              changepasswordtab ? Colors.amber : Colors.grey),
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
                profiletab ? profileTab() : changepasswordTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileTab() {
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
              text: 'Doe123',
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
              text: 'John Doe',
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
            TextRegular(
              text: 'doe123@gmail.com',
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
              text: 'Phone Number:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            TextRegular(
              text: '09090104355',
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
              text: 'Gender:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            TextRegular(
              text: 'Male',
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
              text: 'November 15, 2023',
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
          onPressed: () {},
        ),
      ],
    );
  }

  Widget changepasswordTab() {
    return Column(
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
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
