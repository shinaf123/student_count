import 'package:flutter/material.dart';

Widget passWordtextFiled(
    passordcontroller,
    String? passwordtitle,
    String? passwordhintTextt,
    TextInputType? keybordtype,
    String? Function(String?) validate) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        passwordtitle!,
        style: TextStyle(
            color: Color.fromARGB(255, 162, 163, 164),
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        validator: validate,
        controller: passordcontroller,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.visibility_off,
            color: Color.fromARGB(255, 162, 163, 164),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 162, 163, 164)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          hintText: passwordhintTextt!,
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 162, 163, 164)),
        ),
      )
    ],
  );
}
