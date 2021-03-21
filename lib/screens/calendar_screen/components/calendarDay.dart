import 'package:flutter/material.dart';

Widget calendarDay(String dayName, int dayNum, bool selected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: selected ? Color(0XFF3632b3) : null,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: <Widget>[
        Text(
          dayName,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: selected ? Colors.white : Colors.grey,
          ),
        ),
        Text(
          dayNum.toString(),
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Color(0XFF263064),
          ),
        )
      ],
    ),
  );
}
