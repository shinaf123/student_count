import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_count/UI/Home/student_details.dart';
import 'package:student_count/UI/Login/login_page.dart';
import 'package:student_count/UI/SingUp/singup_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool passwordVisible = false;

  @override
  void InitState1() {
    super.initState();
    passwordVisible = true;
  }

  var searchName = '';
  // final emailCon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () {
            // Get.to(StudentDetails());
            // print(use)
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StudentDetails(
                  // emailContro: emailCon,
                  // passContro: passCon,
                  );
            }));
          },
          label: Text(
            "Add Student Details",
            style: TextStyle(fontSize: 15),
          ),
          icon: Icon(
            Icons.add_sharp,
            size: 22,
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22),
                child: Row(
                  children: [
                    SizedBox(
                      height: 55,
                      width: 305,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchName = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Search student...",
                          prefixIcon: Icon(Icons.search_sharp),
                          prefixIconColor: Colors.black,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return SignupPage();
                          }));
                        },
                        icon: Icon(
                          Icons.logout,
                          size: 39,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 565,
                  width: 375,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SizedBox(
                    height: 400,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Details")
                            .orderBy("Firstname")
                            .startAt([searchName]).endAt(
                                [searchName + "\uf8ff"]).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Connection error");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var docs = snapshot.data!.docs;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: docs.length,
                                itemBuilder: (BuildContext, index) {
                                  var data = snapshot.data!.docs[index];

                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 65,
                                              height: 65,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          data["Image"]),
                                                      fit: BoxFit.cover)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data["Firstname"],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(data["Age"])
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
