import 'package:flutter/material.dart';
import 'package:student_count/ComonUse/navigation_button.dart';
import 'package:student_count/ComonUse/passwordfield.dart';
import 'package:student_count/ComonUse/textfiled.dart';
import 'package:student_count/UI/Home/home_page.dart';
import 'package:student_count/UI/Login/login_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _emailController = TextEditingController();
  final _passwordContrroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                  "Create Account..",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                )),
            Positioned(
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
                decoration: BoxDecoration(
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
                          if (v == null || v.isEmpty) {
                            return "Please enter your correct password";
                          }
                          return null;
                        }),
                        passWordtextFiled(
                            _passwordContrroller,
                            "Conform Password",
                            "Enter the Conform password",
                            TextInputType.visiblePassword, (vv) {
                          if (vv == null || vv.isEmpty) {
                            return "Please enter your correct password";
                          }
                          return null;
                        }),
                        const SizedBox(
                          height: 15,
                        ),
                        custombotton("SignUp", () {
                          if (formKey.currentState!.validate()) {
                            print(_emailController.text);
                            print(_passwordContrroller.text);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          }
                        }, double.infinity),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
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
                              child: Text(
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
}
