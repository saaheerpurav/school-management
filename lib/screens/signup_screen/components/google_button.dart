import 'package:flutter/material.dart';

Widget googleButton(Function onPressFunction, String type) {
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 100,
          height: 2,
          color: Color(0xFFF1E6FF),
        ),
        Center(
          child: Text(
            "OR",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: Color(0xFF6F35A5),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          width: 100,
          height: 2,
          color: Color(0xFFF1E6FF),
        ),
      ],
    ),
    SizedBox(height: 15),
    Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: TextButton(
          onPressed: onPressFunction,
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50)),
          ),
          child: Container(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Image.asset(
                    'images/google.png',
                    width: 20,
                  ),
                ),
                Center(
                  child: Text(
                    "Sign $type with Google",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ]);
}
