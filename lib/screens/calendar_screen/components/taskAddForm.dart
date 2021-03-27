import 'package:flutter/material.dart';

class TaskAddForm extends StatefulWidget {
  Function(Map) callback;
  Map existingData;

  TaskAddForm(this.callback, [this.existingData]);

  @override
  _TaskAddFormState createState() => _TaskAddFormState();
}

class _TaskAddFormState extends State<TaskAddForm> {
  var deadline;
  var taskName;
  var taskDescription;
  var status = 'Incomplete';


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
  void initState() {
    super.initState();
    if(widget.existingData != null){
      var data = widget.existingData;

      setState(() {
        deadline = DateTime.parse(data['deadline']);
        taskName = data['task'];
        taskDescription = data['description'];
        status = data['status'];
      });
    }
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
            var isEdit = widget.existingData != null;
            if(isEdit){
              widget.callback({
                'task': taskName,
                'description': taskDescription,
                'deadline': deadline.toString().split(" ")[0],
                'status': status,
                'isEdit': true,
                'id': widget.existingData['id'],
              });
            }
            else{
              widget.callback({
                'task': taskName,
                'description': taskDescription,
                'deadline': deadline.toString().split(" ")[0],
                'status': status,
                'isEdit': false,
                'id': DateTime.now().millisecondsSinceEpoch,
              });
            }
            Navigator.of(context).pop();
          },
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            initialValue: taskName,
            onChanged: (newText) {
              setState(() {
                taskName = newText;
              });
            },
            decoration: InputDecoration(
              labelText: "Task",
              hintText: "Enter Task Name",
            ),
          ),
          TextFormField(
            initialValue: taskDescription,
            onChanged: (newText) {
              setState(() {
                taskDescription = newText;
              });
            },
            decoration: InputDecoration(
              labelText: "Description",
              hintText: "Enter Task Description (Optional)",
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            child: Text(
              deadline == null
                  ? "Select Deadline"
                  : "Deadline: ${deadline.day}/${deadline.month}/${deadline.year}",
            ),
            onPressed: callDatePicker,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Status:  "),
              DropdownButton<String>(
                value: status,
                items: <String>['Incomplete', 'Complete'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (text) {
                  setState(() {
                    status = text;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
