import 'package:flutter/material.dart';

bool validateEmail(String value) {
  return RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(value);
}

Function showAlert(BuildContext context, String title, String text, Function onPressFunction){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: onPressFunction,
          ),
        ],
      );
    },
  );
}