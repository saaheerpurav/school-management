import 'package:flutter/material.dart';


class JoinSchoolForm extends StatefulWidget {
  @override
  _JoinSchoolFormState createState() => _JoinSchoolFormState();
}

class _JoinSchoolFormState extends State<JoinSchoolForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Join a school"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "School Code",
              hintText: "Enter School Code",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("JOIN"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}