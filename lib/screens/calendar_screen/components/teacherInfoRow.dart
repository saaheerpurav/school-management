import 'package:flutter/material.dart';

Widget teacherInfoRow(String name, String value) {
  return value.trim() != ""
      ? Row(
          children: [
            Text(
              name,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0XFF263064),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey,
              ),
            )
          ],
        )
      : Container();
}
