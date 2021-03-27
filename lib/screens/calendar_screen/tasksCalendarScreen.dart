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

      setState(() {
        if (newData['isEdit'] == true) {
          var task_to_edit = allTasks[allTasks.indexOf(allTasks.firstWhere((e)=>e['id'] == newData['id']))];
          task_to_edit['deadline'] = "${newData['deadline'].split("-").last}st";
          task_to_edit['task'] = newData['task'];
          task_to_edit['description'] = newData['description'];
          task_to_edit['status'] = newData['status'];
          task_to_edit['deadlineMessage'] = deadlineMessage;
          task_to_edit['formWidget'] = TaskAddForm(callback, newData);
          task_to_edit['isComplete'] = deadlineDate > 7;
          task_to_edit['context'] = context;
        } else {
          allTasks.add(
            {
              "deadline": "${newData['deadline'].split("-").last}st",
              "task": newData['task'],
              "description": newData['description'],
              "deadlineMessage": deadlineMessage,
              "formWidget": TaskAddForm(callback, newData),
              "status": newData['status'],
              "isComplete": deadlineDate > 7,
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
                                .map((e) => calendarEvent(
                                      e['deadline'],
                                      "March",
                                      "",
                                      e['task'],
                                      e['description'],
                                      e['deadlineMessage'],
                                      e['formWidget'],
                                      e['status'],
                                      true,
                                      e['isComplete'],
                                      e['context'],
                                    ))
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
