import 'package:flutter/material.dart';
import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/calendarEvent.dart';
import 'package:school_management/screens/calendar_screen/components/taskAddForm.dart';

class TasksCalendarScreen extends StatefulWidget {
  @override
  _TasksCalendarScreenState createState() => _TasksCalendarScreenState();
}

class _TasksCalendarScreenState extends State<TasksCalendarScreen> {
  var data;

  List<Widget> allTasks = [
    calendarEvent(
      "24th",
      "March",
      "",
      "Create Time Table for Class I",
      "Deadline",
      "3 Days left",
      true,
      false,
    ),
    calendarEvent(
      "31st",
      "March",
      "",
      "Create Geography Quiz for Class X",
      "Deadline",
      "10 Days left",
      true,
      true,
    ),
    calendarEvent(
      "28th",
      "March",
      "",
      "Decide Class X Farewell Food Menu",
      "Deadline",
      "7 Days left",
      true,
      true,
    ),
    calendarEvent(
      "3rd",
      "April",
      "",
      "Create Presentaion",
      "Presentaion for Class X on Natural Regions",
      "11 Days left",
      true,
      true,
    ),
    calendarEvent(
      "28th",
      "March",
      "",
      "Create Video",
      "Class X Memories Video for Annual Concert",
      "5 Days left",
      true,
      false,
    ),
  ];

  callback(newData) {
    int deadlineDate = getDate(DateTime.parse(newData['deadline']));
    String deadlineMessage;

    if(deadlineDate == 1){
      deadlineMessage = "1 Day left";
    }
    else{
      deadlineMessage = "$deadlineDate Days left";
    }

    setState(() {
      allTasks.add(
        calendarEvent(
          "${newData['deadline']}st",
          "March",
          "",
          newData['task'],
          newData['description'],
          deadlineMessage,
          true,
          deadlineDate > 7,
        ),
      );
    });
  }

  int getDate(DateTime date) {
    return (date.difference(DateTime.now()).inDays + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TaskAddForm(callback);
            },
          );
        },
      ),
      body: Container(
        padding: EdgeInsets.only(top: 24),
        color: Color(0XFFD4E7FE),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      screenHeader(true, context),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: allTasks,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
