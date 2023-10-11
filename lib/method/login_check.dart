import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/screens/first_page.dart';
import 'package:firebase_login_signup/screens/home_page.dart';
import 'package:flutter/material.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const FirstPage();
          }
        }
      },
    );
  }
}
