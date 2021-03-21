import 'package:flutter/material.dart';

Widget taskContainer(String title, int daysLeft, bool completed) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.all(10),
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      color: completed
          ? Colors.green.withOpacity(0.2)
          : Colors.pink.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Deadline",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey,
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 6,
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: completed ? Colors.green : Colors.red,
              ),
            ),
            Text(
              "$daysLeft Days Left",
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
        SizedBox(height: 5),
        Text(
          title,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Color(0XFF263064),
          ),
        )
      ],
    ),
  );
}
