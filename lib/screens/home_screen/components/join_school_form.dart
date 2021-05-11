import 'package:flutter/material.dart';


class JoinSchoolForm extends StatefulWidget {
  final Function onSubmit;

  JoinSchoolForm(this.onSubmit);

  @override
  _JoinSchoolFormState createState() => _JoinSchoolFormState();
}

class _JoinSchoolFormState extends State<JoinSchoolForm> {
  String code;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Join a school"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value){
              setState(() {
                code = value;
              });
            },
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
            widget.onSubmit(code);
          },
        ),
      ],
    );
  }
}