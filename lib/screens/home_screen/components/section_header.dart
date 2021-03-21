import 'package:flutter/material.dart';

Widget sectionHeader(String title, int num, BuildContext context, Widget screen) {
  return Row(
    children: <Widget>[
      Text(
        title,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 13,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          color: Color(0XFF263064),
        ),
      ),
      Text(
        " ($num)",
        textDirection: TextDirection.ltr,
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
      Spacer(),
      SizedBox(
        height: 30,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          child: Text(
            "See All",
            textDirection: TextDirection.ltr,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Color(
                0XFF263064,
              ),
            ),
          ),
        ),
      )
    ],
  );
}
