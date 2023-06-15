import 'package:flutter/material.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/text_widget.dart';

import '../../../../utils/routes.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 65,
                  ),
                  const Expanded(child: SizedBox()),
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
                  const SizedBox(
                    width: 20,
                  ),
                  ButtonWidget(
                    height: 45,
                    width: 125,
                    label: 'Signup',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextBold(
                text: 'Moving\nis what\nwe love',
                fontSize: 68,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              TextRegular(
                text:
                    'In Pack & Go, we make sure\nyour items is delivered safely.',
                fontSize: 28,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                color: Colors.blue,
                height: 45,
                width: 150,
                label: 'Book now',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
