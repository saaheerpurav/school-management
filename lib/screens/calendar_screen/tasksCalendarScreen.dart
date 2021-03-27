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
  List<Map> allTasks = [];
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  int getDate(DateTime date) {
    return (date.difference(DateTime.now()).inDays + 1);
  }

  @override
  Widget build(BuildContext context) {
    callback(newData) {
      int deadlineDate = getDate(DateTime.parse(newData['deadline']));
      String deadlineMessage;

      if (deadlineDate == 1) {
        deadlineMessage = "1 Day left";
      } else {
        deadlineMessage = "$deadlineDate Days left";
      }
      var date = newData['deadline'].split("-").last.toString();
      var month = newData['deadline'].split("-")[1];
      var dateInt = int.parse(date);
      var monthInt = int.parse(month);

      if (dateInt < 10) {
        date = date[1];
      }

      var lastNum = int.parse(date[date.length - 1]);

      if (lastNum == 1 && (dateInt < 10 || dateInt > 20)) {
        date = "${date}st $month";
      } else if (lastNum == 2 && (dateInt < 10 || dateInt > 20)) {
        date = "${date}nd";
      } else if (lastNum == 3 && (dateInt < 10 || dateInt > 20)) {
        date = "${date}rd";
      } else {
        date = "${date}th";
      }

      switch (monthInt) {
        case 1:
          month = "January";
          break;
        case 2:
          month = "February";
          break;
        case 3:
          month = "March";
          break;
        case 4:
          month = "April";
          break;
        case 5:
          month = "May";
          break;
        case 6:
          month = "June";
          break;
        case 7:
          month = "July";
          break;
        case 8:
          month = "August";
          break;
        case 9:
          month = "September";
          break;
        case 10:
          month = "October";
          break;
        case 11:
          month = "November";
          break;
        case 12:
          month = "December";
          break;
      }

      setState(() {
        if (newData['isEdit'] == true) {
          var taskToEdit = allTasks[allTasks
              .indexOf(allTasks.firstWhere((e) => e['id'] == newData['id']))];
          taskToEdit['deadline'] = date;
          taskToEdit['month'] = month;
          taskToEdit['task'] = newData['task'];
          taskToEdit['description'] = newData['description'];
          taskToEdit['status'] = newData['status'];
          taskToEdit['deadlineMessage'] = deadlineMessage;
          taskToEdit['formWidget'] = TaskAddForm(callback, newData);
          taskToEdit['isComplete'] = deadlineDate > 7;
          taskToEdit['context'] = context;
        } else {
          allTasks.add(
            {
              "deadline": date,
              "month": month,
              "task": newData['task'],
              "description": newData['description'],
              "deadlineMessage": deadlineMessage,
              "formWidget": TaskAddForm(callback, newData),
              "status": newData['status'],
              "isComplete": deadlineDate > 7,
              "color": (colors.toList()..shuffle()).first,
              "context": context,
              'id': newData['id'],
            },
          );
        }
      });
    }

    /* allTasks = [
      calendarEvent(
        "24th",
        "March",
        "",
        "Create Time Table for Class I",
        "Deadline",
        "3 Days left",
        TaskAddForm(callback),
        "Incomplete",
        true,
        false,
        context,
      ),
      calendarEvent(
        "31st",
        "March",
        "",
        "Create Geography Quiz for Class X",
        "Deadline",
        "10 Days left",
        TaskAddForm(callback),
        "Incomplete",
        true,
        true,
        context,
      ),
      calendarEvent(
        "28th",
        "March",
        "",
        "Decide Class X Farewell Food Menu",
        "Deadline",
        "7 Days left",
        TaskAddForm(callback),
        "Complete",
        true,
        true,
        context,
      ),
      calendarEvent(
        "3rd",
        "April",
        "",
        "Create Presentaion",
        "Presentaion for Class X on Natural Regions",
        "11 Days left",
        TaskAddForm(callback),
        "Complete",
        true,
        true,
        context,
      ),
      calendarEvent(
        "28th",
        "March",
        "",
        "Create Video",
        "Class X Memories Video for Annual Concert",
        "5 Days left",
        TaskAddForm(callback),
        "Incomplete",
        true,
        false,
        context,
      ),
    ];*/

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
                          padding: EdgeInsets.only(top: 20, bottom: 70),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: allTasks
                                .map(
                                  (e) => calendarEvent(
                                    e['deadline'],
                                    e['month'],
                                    "",
                                    e['task'],
                                    e['description'],
                                    e['deadlineMessage'],
                                    e['formWidget'],
                                    e['status'],
                                    true,
                                    e['isComplete'],
                                    e['color'],
                                    e['context'],
                                  ),
                                )
                                .toList(),
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
