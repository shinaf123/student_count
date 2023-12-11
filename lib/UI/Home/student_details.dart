import 'package:flutter/material.dart';
import 'package:student_count/ComonUse/navigation_button.dart';
import 'package:student_count/ComonUse/textfiled.dart';

List<String> list = <String>['Gender', 'Male', 'Female', 'Other'];

class StudentDetails extends StatefulWidget {
  StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final _firstname = TextEditingController();

  final _lastname = TextEditingController();

  final _age = TextEditingController();

  final _gender = TextEditingController();

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 58,
                ),
                textfieledCustom("First Name", "Enter the First Name",
                    _firstname, TextInputType.name, (v) {}),
                textfieledCustom("Last Name", "Enter the Last Name", _lastname,
                    TextInputType.name, (v) {}),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: _age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Age",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 162, 163, 164))),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
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
                        dropdownMenuEntries:
                            list.map<DropdownMenuEntry<String>>((String value) {
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
                custombotton("Save", () {}, double.infinity)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
