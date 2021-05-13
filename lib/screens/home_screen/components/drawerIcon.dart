import 'package:flutter/material.dart';

Widget drawerIcon(BuildContext context, [EdgeInsets margin]){
  return Container(
    margin: margin ?? EdgeInsets.only(left: 5),
    width: 40,
    child: TextButton(
      onPressed: () =>
          Scaffold.of(context).openDrawer(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<
            RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      child: Icon(
        Icons.menu,
        color: Color(0XFF263064),
      ),
    ),
  );
}