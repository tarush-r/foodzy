import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/screens/home_screen.dart';
import 'package:kjsce_hack_2022/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}