import 'package:flutter/material.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/textfield_widget.dart';

import '../../../../utils/routes.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

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
          const SizedBox(
            height: 50,
          ),
          TextBold(
            text: 'Login',
            fontSize: 38,
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
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
            label: 'Login',
            onPressed: () {},
          ),
          const SizedBox(
            height: 20,
          ),
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
    );
  }
}
