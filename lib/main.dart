// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:packandgo/utils/routes.dart';
import 'package:packandgo/views/business/auth/login_screen.dart';
import 'package:packandgo/views/business/auth/signup_screen.dart';
import 'package:packandgo/views/business/business_home_screen.dart';
import 'package:packandgo/views/business/business_profile_screen.dart';
import 'package:packandgo/views/drivers/auth/login_screen.dart';
import 'package:packandgo/views/drivers/auth/signup_screen.dart';
import 'package:packandgo/views/drivers/driver_home_screen.dart';
import 'package:packandgo/views/drivers/driver_profile_screen.dart';
import 'package:packandgo/views/users/web/screens/auth/landing_screen.dart';
import 'package:packandgo/views/users/web/screens/auth/learn_more_screen.dart';
import 'package:packandgo/views/users/web/screens/auth/login_screen.dart';
import 'package:packandgo/views/users/web/screens/auth/signup_screen.dart';
import 'package:packandgo/views/users/web/screens/home_screen.dart';
import 'package:packandgo/views/users/web/screens/my_profile.dart';
import 'package:packandgo/views/users/web/screens/records_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "packandgo-86489",
    options: const FirebaseOptions(
        apiKey: "AIzaSyAmkI_vbu64bvEFMg2novgZuc2X8IQet3Y",
        authDomain: "pack-ac557.firebaseapp.com",
        projectId: "pack-ac557",
        storageBucket: "pack-ac557.appspot.com",
        messagingSenderId: "82321265642",
        appId: "1:82321265642:web:1805e5eacfaee9282d5893"),
  );

  final SharedPreferences userData = await SharedPreferences.getInstance();
  var details = userData.getString('userDetails');
  var userDetails = details != null ? json.decode(details) : null;
  print("user details $userDetails");
  runApp(MyApp(userDetails));
}

class MyApp extends StatelessWidget {
  var userDetails;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyApp(this.userDetails);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pack and Go',
      home: const LandingScreen(),
      routes: {
        Routes.homepage: (context) => const HomeScreen(),
        Routes.landingpage: (context) => const LandingScreen(),
        Routes.loginpage: (context) => LoginScreen(),
        Routes.signuppage: (context) => const SignupScreen(),
        Routes.learnmore: (context) => LearnMore(),
        Routes.recordspage: (context) => RecordsScreen(),
        Routes.profilepag: (context) => MyProfile(),
        Routes.driverloginpage: (context) => DriverLoginScreen(),
        Routes.driversignuppage: (context) => DriverSignupScreen(),
        Routes.driverhomescreen: (context) => DriverHomeScreen(),
        Routes.driverprofilescreen: (context) => DriverProfileScreen(),
        Routes.businessloginpage: (context) => BusinessLoginScreen(),
        Routes.businesssignuppage: (context) => BusinessSignupScreen(),
        Routes.businesshomescreen: (context) => BusinessHomeScreen(),
        Routes.businessprofilescreen: (context) => BusinessProfileScreen(),
      },
    );
  }

  // User Auto login
  Widget loginUser(context) {
    if (userDetails != null && _auth.currentUser != null) {
      // if (userDetails['user_type'] == 'division-administrator') {
      //   return DivAdminDashboard();
      // } else if (userDetails['user_type'] == 'school-head-administrator') {
      //   return SchoolAdminDashboard();
      // } else {
      //   return TeacherDashboard();
      // }
      return HomeScreen();
    } else {
      return LandingScreen();
    }
  }
}
