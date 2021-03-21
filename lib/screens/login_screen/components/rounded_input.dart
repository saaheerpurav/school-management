import 'package:flutter/material.dart';

Widget roundedInput(String placeholder, IconData icon){
  return Center(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
          fillColor: Color(0xFFF1E6FF),
          filled: true,
          hintText: placeholder,
          prefixIcon: Icon(icon, color: Color(0xFF6F35A5), size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (String value){
          debugPrint("You said $value");
        },
      ),
    )
  );
}