import 'package:flutter/material.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';

import '../../../../utils/routes.dart';
import '../../../../widgets/button_widget.dart';
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

  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              color: primary,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
            TextFieldWidget(
                width: 500,
                label: 'First Name',
                controller: firstnameController),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                width: 500, label: 'Last Name', controller: lastnameController),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                inputType: TextInputType.number,
                width: 500,
                label: 'Contact Number',
                controller: contactnumberController),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                width: 500, label: 'Email', controller: emailController),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                isObscure: true,
                isPassword: true,
                width: 500,
                label: 'Password',
                controller: passwordController),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              radius: 5,
              color: Colors.green[500],
              height: 45,
              width: 500,
              label: 'Signup',
              onPressed: () {
                showToast('Account created successfuly!');
                Navigator.pushNamed(context, Routes.loginpage);
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
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
