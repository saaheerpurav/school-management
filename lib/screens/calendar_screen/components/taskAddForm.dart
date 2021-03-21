import 'package:flutter/material.dart';

class TaskAddForm extends StatefulWidget {
  Function(List) callback;
  TaskAddForm(this.callback);

  @override
  _TaskAddFormState createState() => _TaskAddFormState();
}

class _TaskAddFormState extends State<TaskAddForm> {
  var deadline;
  var enteredText;

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      deadline = order;
    });
  }

  Future<DateTime> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Task"),
      actions: <Widget>[
        TextButton(
          child: Text("CANCEL"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text("ADD"),
          onPressed: () {
            widget.callback([enteredText, deadline.toString().split(" ")[0]]);
            Navigator.of(context).pop();
          },
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            onChanged: (newText) {
              enteredText = newText;
            },
            decoration: InputDecoration(
              labelText: "Task",
              hintText: "Enter Task Name",
            ),
          ),
          TextButton(
            child: Text("Pick Date"),
            onPressed: callDatePicker,
          )
        ],
      ),
    );
  }
}
