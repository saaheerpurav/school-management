import 'package:flutter/material.dart';

import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/calendarEvent.dart';
import 'package:school_management/screens/calendar_screen/components/taskAddForm.dart';

import 'package:school_management/data/tasks.dart';
import 'package:school_management/data/colors.dart';

import 'package:school_management/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TasksCalendarScreen extends StatefulWidget {
  @override
  _TasksCalendarScreenState createState() => _TasksCalendarScreenState();
}

class _TasksCalendarScreenState extends State<TasksCalendarScreen> {
  List<Map> allTasks;
  List<Map> newTaskList = [];

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String docId;

  int getDate(DateTime date) {
    return (date.difference(DateTime.now()).inDays + 1);
  }

  @override
  void initState() {
    super.initState();

    users
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data();
        setState(() {
          docId = doc.id;

          allTasks = [];
          if (data['tasks'] != null) {
            for (var i in data['tasks']) {
              allTasks.add(
                {
                  "deadline": i['deadline'],
                  "month": i['month'],
                  "task": i['task'],
                  "description": i['description'],
                  "deadlineMessage": i['deadlineMessage'],
                  "formWidget": TaskAddForm(callback, i),
                  "status": i['status'],
                  "color": Color(int.parse(i['color'])),
                  "context": context,
                  'id': i['id'],
                },
              );
            }
          }
        });
      });
    });
  }

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
      date = "${date}st";
    } else if (lastNum == 2 && (dateInt < 10 || dateInt > 20)) {
      date = "${date}nd";
    } else if (lastNum == 3 && (dateInt < 10 || dateInt > 20)) {
      date = "${date}rd";
    } else {
      date = "${date}th";
    }

    month = getMonthName(monthInt);

    setState(
      () {
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
              "color": (colors.toList()..shuffle()).first,
              "context": context,
              'id': newData['id'],
            },
          );
        }

        List tasksToSend = [];

        for (var i in allTasks) {
          var colourTemp = i['color'].toString().split("0xff")[1];
          String colourString = "0xff" + colourTemp.substring(0, colourTemp.length - 1);

          tasksToSend.add({
            "deadline": i['deadline'],
            "month": i['month'],
            "task": i['task'],
            "description": i['description'],
            "deadlineMessage": i['deadlineMessage'],
            "status": i['status'],
            "color": colourString,
            'id': i['id'],
          });
        }

        users.doc(docId).update({'tasks': tasksToSend});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (allTasks != null) {
      allTasks.sort((a, b) => (a['id']).compareTo(b['id']));
      newTaskList = [];

      for (var i in allTasks) {
        if (i['status'] == "Incomplete") {
          newTaskList.add(i);
        }
      }
      for (var i in allTasks) {
        if (i['status'] == "Complete") {
          newTaskList.add(i);
        }
      }
    }

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
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 20, bottom: 70),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: allTasks == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : allTasks.isEmpty
                                  ? Text(
                                      "You have no tasks",
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF263064),
                                      ),
                                    )
                                  : Column(
                                      children: newTaskList
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
