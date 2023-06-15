import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:packandgo/utils/routes.dart';
import 'package:packandgo/views/web/screens/auth/landing_screen.dart';
import 'package:packandgo/views/web/screens/auth/login_screen.dart';
import 'package:packandgo/views/web/screens/auth/signup_screen.dart';
import 'package:packandgo/views/web/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "packandgo-86489",
    options: const FirebaseOptions(
        authDomain: "packandgo-86489.firebaseapp.com",
        apiKey: "AIzaSyBBnZDZEdz0iafvxFjx-77cR4cJRmzgoeQ",
        appId: "1:370229023048:web:2939922840604ae142a37d",
        messagingSenderId: "370229023048",
        projectId: "packandgo-86489",
        storageBucket: "packandgo-86489.appspot.com"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      },
    );
  }
}
