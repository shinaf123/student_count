import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_count/ComonUse/navigation_button.dart';
import 'package:student_count/ComonUse/passwordfield.dart';
import 'package:student_count/ComonUse/textfiled.dart';
import 'package:student_count/UI/Home/home_page.dart';
import 'package:student_count/UI/SingUp/singup_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = false;
  final _passwordContrroller = TextEditingController();

  final _emailController = TextEditingController();

  final formKey1 = GlobalKey<FormState>();

  final isGoogleLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  loginUser({email, password}) async {
    try {
      var halo = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userids = FirebaseAuth.instance.currentUser?.uid.toString();
      await prefs.setString('uid', userids!);
      print(prefs.getString('uid'));
      print(halo);
      setState(() {
        isLogin = true;
      });
      return halo;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }

      return null;
    }
  }

  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      await SignupPage.instance.signInWithGoogle();
      isGoogleLoading.value = false;
    } catch (e) {
      isGoogleLoading.value = false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordContrroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Center(
        child: Stack(
          children: [
            Positioned(
                top: 70,
                left: 20,
                child: Text(
                  "Login Here!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                )),
            Positioned(
                top: 110,
                left: 20,
                child: Text(
                  "Welcome Back you`ve been missed!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 188),
                height: 614,
                width: 375,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Form(
                    key: formKey1,
                    child: Column(
                      children: [
                        textfieledCustom(
                            "Email",
                            "Enter your email",
                            _emailController,
                            TextInputType.emailAddress, (validate) {
                          if (validate == null || validate.isEmpty) {
                            return 'Please enter your  Email.';
                          }
                          return null;
                        }),
                        passWordtextFiled(
                            _passwordContrroller,
                            "Password",
                            "Enter the password",
                            TextInputType.visiblePassword, (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter your correct password";
                          }
                          return null;
                        }),
                        const SizedBox(
                          height: 15,
                        ),
                        custombotton("SignIn", () async {
                          if (formKey1.currentState!.validate()) {
                            await loginUser(
                                email: _emailController.text,
                                password: _passwordContrroller.text);

                            print(_emailController.text);
                            print(_passwordContrroller.text);

                            if (isLogin) {
                              return Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }));
                            } else {
                              return print("error");
                            }
                          }
                        }, double.infinity),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1.0,
                                color: Color.fromARGB(255, 162, 163, 164),
                              ),
                            ),
                            Text(
                              " Or continue with ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 162, 163, 164)),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 1.0,
                                color: Color.fromARGB(255, 162, 163, 164),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  googleSignIn();
                                });
                              },
                              child: Container(
                                height: 56,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 150, 149, 149))),
                                child: Image.asset(
                                    "assets/pngicons/google-symbol 1.png"),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  height: 56,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 150, 149, 149))),
                                  child: Icon(Icons.phone_android_outlined)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 162, 163, 164)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignupPage();
                                }));
                              },
                              child: Text(
                                ' Sign Up',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
