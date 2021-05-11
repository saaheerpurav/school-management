import 'package:flutter/material.dart';

Widget teacherInfoRow(String name, String value) {
  return value.trim() != ""
      ? Row(
          children: [
            Text(
              name,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0XFF263064),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey,
              ),
            )
          ],
        )
      : Container();
}

Widget skillInterestItem(String item, Color color){
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      border:
      Border.all(color: color, width: 2),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Text(
      item,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: color,
      ),
    ),
  );
}
