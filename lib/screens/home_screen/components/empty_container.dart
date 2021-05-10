import 'package:flutter/material.dart';

Widget emptyContainer(String text) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text),
  );
}
