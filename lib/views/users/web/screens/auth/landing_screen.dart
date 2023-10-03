// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/text_widget.dart';
import '../../../../../utils/routes.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            text: 'LOGIN',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ButtonWidget(
                          height: 45,
                          width: 125,
                          label: 'SIGNUP',
                          color: primary,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signuppage);
                          },
                        ),
                        const SizedBox(width: 20),
                        ButtonWidget(
                          fontSize: 14,
                          height: 45,
                          width: 150,
                          label: 'Continue as Driver',
                          color: primary,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.driverloginpage);
                          },
                        ),
                        const SizedBox(width: 20),
                        ButtonWidget(
                          fontSize: 14,
                          height: 45,
                          width: 150,
                          label: 'Continue as Business Owner',
                          color: primary,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.businessloginpage);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextBold(
                      text: 'Moving\nis what\nwe love',
                      fontSize: 68,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    TextRegular(
                      text:
                          'In Pack & Go, we make sure\nyour items is delivered safely.',
                      fontSize: 28,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget(
                      color: Colors.blue,
                      height: 45,
                      width: 150,
                      label: 'Book now',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.loginpage);
                      },
                    ),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: primary,
                    elevation: 4,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.white,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        children: [
                          SizedBox(height: 100),
                          Text("CHOOSE A VEHICLE"),
                          Text(
                            "From Public to Private UVs, \nversatility is the key",
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.learnmore,
                                  arguments: {"learn-type": "vehicle"});
                            },
                            child: Text(
                              "Learn More",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Card(
                    elevation: 4,
                    color: primary,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.white,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        children: [
                          SizedBox(height: 100),
                          Text("CHOOSE A LOADER"),
                          Text(
                            "Eficientcy and care in every \nload",
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.learnmore,
                                  arguments: {"learn-type": "loader"});
                            },
                            child: Text(
                              "Learn More",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            ButtonWidget(
              color: Colors.blue,
              height: 45,
              width: 150,
              label: 'Book now',
              onPressed: () {
                Navigator.pushNamed(context, Routes.loginpage);
              },
            ),
            SizedBox(height: 300),
            Container(
              color: primary,
              padding: EdgeInsets.only(top: 100, bottom: 10),
              alignment: Alignment.bottomCenter,
              child: Text(
                "PACK&GO 2022",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
