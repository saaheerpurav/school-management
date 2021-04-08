import 'package:flutter/material.dart';

Widget classContainer(
    String title, bool bottomPadding, String time, String room) {
  return Container(
    margin: EdgeInsets.only(top: 10, bottom: bottomPadding ? 20 : 0),
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Color(0XFFefefef),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Text(
                time,
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
                "AM",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey),
              )
            ],
          ),
        ),
        Container(
          height: 80,
          width: 2,
          color: Colors.grey.withOpacity(0.2),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF263064),
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on_sharp,
                    color: Colors.grey.withOpacity(0.4),
                    size: 17,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 7),
                    width: 150,
                    child: Text(
                      room,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
