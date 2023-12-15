import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:student_count/ComonUse/navigation_button.dart';
import 'package:student_count/ComonUse/passwordfield.dart';
import 'package:student_count/ComonUse/textfiled.dart';
import 'package:student_count/UI/Home/home_page.dart';
import 'package:student_count/UI/Login/login_page.dart';
// import '../../getX/getx.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  static SignupPage get instance => Get.find();

  final _emailController = TextEditingController();
  final _passwordContrroller = TextEditingController();
  final _ConPasswordContrroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

// final UserController userController = Get.lazyPut(() => userController());

  FirebaseAuth auth = FirebaseAuth.instance;

  loginUser({email, password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  createUser({email, password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Center(
        child: Stack(
          children: [
            const Positioned(
                top: 70,
                left: 20,
                child: Text(
                  "Create Account..",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                )),
            const Positioned(
                top: 110,
                left: 20,
                child: Text(
                  "Create an account so you can see"
                  "\n"
                  "all the student details!!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 188),
                height: 614,
                width: 375,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Form(
                    key: formKey,
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
                          RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])');
                          var passNonNullValue = v ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("Password is required");
                          } else if (!regex.hasMatch(passNonNullValue)) {
                            return ("Password should contain"
                                "\n"
                                "upper,lower,digit ");
                          }
                          return null;
                        }),
                        passWordtextFiled(
                            _ConPasswordContrroller,
                            "Conform Password",
                            "Enter the Conform password",
                            TextInputType.visiblePassword, (vv) {
                          if (vv!.isEmpty) return 'Empty';
                          if (vv != _passwordContrroller.text)
                            return 'Not Match';
                          return null;
                        }),
                        const SizedBox(
                          height: 15,
                        ),
                        custombotton("SignUp", () async {
                          if (formKey.currentState!.validate()) {
                            await createUser(
                                email: _emailController.text,
                                password: _passwordContrroller.text);

                            print(_emailController.text);
                            print(_passwordContrroller.text);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));

                            // Get.to(HomePage());
                          }
                        }, double.infinity),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account!",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 162, 163, 164)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }));
                              },
                              child: const Text(
                                ' Sign In',
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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      final ex = TlsException(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TlsException();
      throw ex.message;
    }
  }
}
