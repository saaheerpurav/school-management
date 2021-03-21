import 'package:flutter/material.dart';

Widget iconButton(String asset) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Color(0xFFF1E6FF))
    ),
    child: Image.asset(
      asset,
      width: 20,
    ),
  );
}