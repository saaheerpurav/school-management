import 'package:flutter/material.dart';
import 'package:school_management/functions.dart';

class ClassScheduleForm extends StatefulWidget {
  final Function callback;

  ClassScheduleForm(this.callback);

  @override
  _ClassScheduleFormState createState() => _ClassScheduleFormState();
}

class _ClassScheduleFormState extends State<ClassScheduleForm> {
  String className;
  String standard;
  String weekday = "Monday";
  String classTime;

  void callTimePicker() async {
    var time = await getTime();
    if (time != null) {
      setState(() {
        classTime = dateToReadableTime(time);
      });
    }
  }

  Future<TimeOfDay> getTime() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Schedule Class",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Subject",
              hintText: "Example - Math",
            ),
            onChanged: (String value) {
              setState(() {
                className = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Class",
              hintText: "Example - Standard 10",
            ),
            onChanged: (String value) {
              setState(() {
                standard = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Day:  "),
              DropdownButton<String>(
                value: weekday,
                items: <String>[
                  "Sunday",
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday",
                  "Saturday",
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    weekday = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Time:  "),
              TextButton(
                onPressed: callTimePicker,
                child:
                    Text(classTime == null ? "Select Class Time" : classTime),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("CANCEL"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text("SCHEDULE"),
          onPressed: () {
            if (className != null && className.trim() != "" && standard != null && standard.trim() != "" && weekday != null && classTime != null) {
              widget.callback({
                'name': className,
                'day': weekday,
                'time': classTime,
                'class': standard,
                'notificationAdded': false,
              });
              Navigator.of(context).pop();
            } else {
              showAlert(context, "Error", "Please enter the class details", (){
                Navigator.of(context).pop();
              });
            }
          },
        )
      ],
    );
  }
}
