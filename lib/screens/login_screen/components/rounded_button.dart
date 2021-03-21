import 'package:flutter/material.dart';

Widget roundedButton(String placeholder, BuildContext context, String route, Color color, [Color textColor]) {
  return Center(
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        color: color,
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text(
          placeholder,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: textColor != null ? textColor : Colors.white,
          ),
        ),
      ),
    ),
  );
}
