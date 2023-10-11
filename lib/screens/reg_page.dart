import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/screens/login_page.dart';
import 'package:firebase_login_signup/widget/button.dart';
import 'package:flutter/material.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final auth = FirebaseAuth.instance;
  bool passwordVisible = false;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset('assets/Signup.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.44,
                  right: MediaQuery.of(context).size.width * 0.38,
                  top: MediaQuery.of(context).size.height * 0.1),
              child: const Text(
                'SIGNUP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                      left: MediaQuery.of(context).size.width * 0.15,
                      right: MediaQuery.of(context).size.width * 0.15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.68,
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none),
                            fillColor: const Color.fromARGB(255, 245, 223, 249),
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.68,
                        child: TextField(
                          controller: pass,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            fillColor: const Color.fromARGB(255, 245, 223, 249),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                  color: Color.fromARGB(255, 111, 53, 165),
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            alignLabelWithHint: false,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Button(
                        text: 'SIGNUP',
                        screen: () async {
                          try {
                            final suser =
                                await auth.createUserWithEmailAndPassword(
                              email: email.text,
                              password: pass.text,
                            );

                            // ignore: unnecessary_null_comparison
                            if (suser != null) {
                              // ignore: use_build_context_synchronously
                              showSnackBarMessage(
                                  context, 'Registration successful');
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                            child: const Text(
                              'Already have an account? Login',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 111, 53, 165),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
