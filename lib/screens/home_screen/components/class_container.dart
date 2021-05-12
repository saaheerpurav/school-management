import 'package:flutter/material.dart';

Widget classContainer(Map data) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Color(0XFFefefef),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        Text(
          data['time'].split(" ")[0],
          textDirection: TextDirection.ltr,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Color(0XFF263064),
          ),
        ),
        SizedBox(width: 4),
        Text(
          data['time'].split(" ")[1],
          textDirection: TextDirection.ltr,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey,
          ),
        ),
        Container(
          height: 60,
          width: 2,
          color: Colors.grey.withOpacity(0.4),
          margin: EdgeInsets.symmetric(horizontal: 5),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['name'],
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0XFF263064),
              ),
            ),
            Text(
              data['class'],
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
