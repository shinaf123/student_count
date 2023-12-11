import 'package:flutter/material.dart';
import 'package:student_count/UI/Home/student_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StudentDetails();
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: 55,
                  child: TextField(
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
                    child: ListView.builder(itemBuilder: (BuildContext, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shinaf Muhammad",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("Age:16")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: Stack(
      //     children: [
      //       Positioned(
      //           top: 20,
      //           child: TextField(
      //             decoration: InputDecoration(
      //               filled: true,
      //               fillColor: Colors.white,
      //               prefix: const Icon(
      //                 Icons.search_sharp,
      //                 color: Color.fromARGB(255, 12, 12, 12),
      //               ),
      //               enabledBorder: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(10),
      //                 borderSide:
      //                     const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
      //               ),
      //               focusedBorder: OutlineInputBorder(
      //                 borderSide: const BorderSide(
      //                   color: Colors.black,
      //                 ),
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //             ),
      //           )),
      //       Center(
      //         child: Container(
      //           margin: EdgeInsets.only(top: 150),
      //           height: 614,
      //           width: 375,
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(30),
      //                   topRight: Radius.circular(30))),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
