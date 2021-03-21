import 'package:flutter/material.dart';

Widget screenHeader(bool isTasks, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    margin: EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        SizedBox(
          width: 50,
          child: TextButton.icon(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0XFF263064),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            label: Text(""),
          ),
        ),
        Text(
          isTasks ? "Your Tasks" : "March ",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Color(0XFF263064),
          ),
        ),
        Text(
          isTasks ? "" : "2021",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: Color(0XFF263064),
          ),
        ),
        Spacer(),
        Text(
          "Today",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: Color(0XFF263064),
          ),
        ),
      ],
    ),
  );
}
