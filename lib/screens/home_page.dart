import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/screens/first_page.dart';
import 'package:firebase_login_signup/widget/button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final User? id = FirebaseAuth.instance.currentUser;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Home page',
          ),
          backgroundColor: const Color.fromARGB(255, 111, 53, 165),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'welcome',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                id?.email ?? '',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 40,
              ),
              Button(
                  text: 'LOGOUT',
                  screen: () {
                    _auth.signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FirstPage()));
                  })
            ],
          ),
        ));
  }
}
