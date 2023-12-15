import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_count/ComonUse/navigation_button.dart';
import 'package:student_count/ComonUse/textfiled.dart';
import 'package:student_count/UI/Home/home_page.dart';

// import 'package:student_count/getX/image_picker_controller.dart';
List<String> list = <String>['Gender', 'Male', 'Female', 'Other'];

class StudentDetails extends StatefulWidget {
  StudentDetails({super.key});

  // final emailContro;
  // final passContro;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Rx<File> image = File("").obs;

  final _firstname = TextEditingController();

  final _lastname = TextEditingController();

  final _age = TextEditingController();

  final _gender = TextEditingController();

  String dropdownValue = list.first;

  Future<void> saveData() async {
    final firstName = _firstname.text;
    final lastName = _lastname.text;
    final age = _age.text;
    final gender = _gender.text;

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    String? userIds = firebaseAuth.currentUser?.uid;
    FirebaseFirestore.instance.collection("Details").doc(userIds).set({
      "Firstname": firstName,
      "Lastname": lastName,
      "Age": age,
      "Gender": gender,
      "Userid": userIds,
      "Image": imageUrl
    });
  }

  final formKeyy = GlobalKey<FormState>();
  final key = GlobalKey<FormState>();

  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ImagePickerController());

    // String imageUrl = "";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Form(
              key: formKeyy,
              child: Column(
                children: [
                  Obx(() {
                    return GestureDetector(
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              //pick image
                                              ImagePicker imagePicker =
                                                  ImagePicker();
                                              XFile? file =
                                                  await imagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);

                                              if (file == null) return;

                                              String uniqueFileName =
                                                  DateTime.now()
                                                      .microsecondsSinceEpoch
                                                      .toString();

                                              final imageTemp = File(file.path);
                                              image.value = imageTemp;

                                              //Upload to firebase_storage
                                              Reference referenceRoot =
                                                  FirebaseStorage.instance
                                                      .ref();
                                              Reference referenceDirImages =
                                                  referenceRoot.child("images");

                                              //create a reference for the image to be stored
                                              Reference referenceImagetoUpload =
                                                  referenceDirImages
                                                      .child(uniqueFileName);

                                              try {
                                                // store the file
                                                await referenceImagetoUpload
                                                    .putFile(File(file!.path));

                                                //success : get the download URL
                                                imageUrl =
                                                    await referenceImagetoUpload
                                                        .getDownloadURL();
                                              } catch (e) {}
                                            },
                                            icon: const Icon(
                                              Icons.collections,
                                              size: 40,
                                            )),
                                        IconButton(
                                            onPressed: () async {
                                              final filee = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                            },
                                            icon: const Icon(
                                              Icons.photo_camera,
                                              size: 40,
                                            ))
                                      ]),
                                )),
                        child: image.value.path == ''
                            ? const CircleAvatar(
                                backgroundColor: Colors.black,
                                maxRadius: 50,
                              )
                            : Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            FileImage(File(image.value.path)),
                                        fit: BoxFit.cover)),
                              ));
                  }),
                  textfieledCustom("First Name", "Enter the First Name",
                      _firstname, TextInputType.name, (v) {
                    if (v == null || v.isEmpty) {
                      return "Enter input";
                    }
                    return null;
                  }),
                  textfieledCustom("Last Name", "Enter the Last Name",
                      _lastname, TextInputType.name, (vv) {
                    if (vv == null || vv.isEmpty) {
                      return "Enter";
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          key: key,
                          controller: _age,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Age",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 162, 163, 164))),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.red))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter age";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownMenu<String>(
                          width: 170,
                          controller: _gender,
                          initialSelection: list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: list
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  custombotton("Save", () {
                    if (formKeyy.currentState!.validate()) {
                      saveData();
                      // uploadImageToFirebase();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    }
                  }, double.infinity)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
