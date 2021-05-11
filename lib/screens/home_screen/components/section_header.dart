import 'package:flutter/material.dart';

Widget sectionHeader(String title, [BuildContext context, String route]) {
  return Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Row(
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
        Spacer(),
        SizedBox(
          height: 30,
          child: route != null
              ? TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      route,
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
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
        )
      ],
    ),
  );
}
