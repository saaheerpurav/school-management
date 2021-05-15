import 'package:flutter/material.dart';

import 'package:school_management/screens/home_screen/components/section_header.dart';
import 'package:school_management/screens/home_screen/components/task_container.dart';
import 'package:school_management/screens/home_screen/components/class_container.dart';
import 'package:school_management/screens/home_screen/components/empty_container.dart';
import 'package:school_management/screens/home_screen/components/join_school_form.dart';
import 'package:school_management/screens/home_screen/components/drawerIcon.dart';
import 'package:school_management/functions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> todayClasses;
  List<Map> allClasses;
  List<Map> allTasks;
  List<String> allAchievements;

  String schoolName;
  String schoolCode;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference schools =
      FirebaseFirestore.instance.collection('schools');

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationDetails platformChannelSpecifics;

  String name = "";
  String email = FirebaseAuth.instance.currentUser.email;
  String docId;
  String profilePicUrl;
  String defaultProfilePicUrl =
      "https://firebasestorage.googleapis.com/v0/b/school-management-4ac50.appspot.com/o/profile_pictures%2Fdefault_image.png?alt=media&token=dfee52bd-a093-4cf3-bbf4-4e5b0b5ed22f";

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getUrl() async {
    String url;

    try {
      Reference ref =
          FirebaseStorage.instance.ref().child("profile_pictures/$email");
      url = (await ref.getDownloadURL()).toString();
    } on Exception catch (_) {
      url = FirebaseAuth.instance.currentUser.photoURL;
    }

    setState(() {
      profilePicUrl = url;
    });
  }

  Future scheduleNotification(
      int id, String title, String description, var time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      description,
      time,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          'id',
          'Class Reminder',
          'Reminds the teacher about the class 5 minutes before it.',
          importance: Importance.max,
          priority: Priority.max,
          showWhen: true,
        ),
      );
    });

    users
        .where('email', isEqualTo: email)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data();

        setState(() {
          name = data['name'];
          schoolCode = data['school_code'];
          allAchievements =
              data['achievements'] == null ? [] : [...data['achievements']];

          todayClasses = [];
          allClasses = [];
          if (data['classes'] != null) {
            for (var class_ in data['classes']) {
              allClasses.add(class_);
              if (class_['day'].substring(0, 3) ==
                  getDayName(DateTime.now().weekday)) todayClasses.add(class_);
            }
          }

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
                  "deadlineMessage": getDeadlineMessage(
                      DateTime.parse(getCorrectDateFormat(i))),
                  "status": i['status'],
                  "color": Color(int.parse(i['color'])),
                },
              );
            }
          }
        });
        if (data['school_code'] != null) {
          getSchoolNameFromCode(data['school_code']);
        }
      });
      getUrl();

      if (allClasses != null && allClasses.isNotEmpty && docId != null) {

        bool shouldUpdate = false;
        int counter = 0;

        for (var class_ in allClasses) {
          if (class_['day'].substring(0, 3) ==
                  getDayName(DateTime.now().weekday) &&
              !class_['notificationAdded']) {
            scheduleNotification(
              counter,
              "Reminder",
              "Your ${class_['name']} class with ${class_['class']} starts in 5 minutes.",
              readableTimeToDate(class_['time'], true),
            );
            class_['notificationAdded'] = true;
            shouldUpdate = true;
          }
          else if(class_['day'].substring(0, 3) !=
              getDayName(DateTime.now().weekday)){
            class_['notificationAdded'] = false;
            shouldUpdate = true;
          }
          counter += 1;
        }
        if (shouldUpdate) {
          users.doc(docId).update({
            'classes': allClasses,
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getSchoolNameFromCode(String code) {
    schools
        .where('school_code', isEqualTo: code)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          schoolName = doc.data()['name'];
          schoolCode = doc.data()['school_code'];
        });
      });
    });
  }

  joinSchool(String code) {
    users.doc(docId).update({
      'school_code': code,
    }).whenComplete(getSchoolNameFromCode(code));
    Navigator.of(context).pop();
  }

  leaveSchool() {
    setState(() {
      schoolName = null;
      schoolCode = null;
      allAchievements = [];
      allClasses = null;
      todayClasses = null;
    });

    users.doc(docId).update({
      'school_code': FieldValue.delete(),
      'achievements': FieldValue.delete(),
      'classes': FieldValue.delete(),
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var formattedDate = "${date.day} ${getMonthName(date.month)}";

    return Container(
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
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              drawerIcon(context),
                              Spacer(),
                              Text(
                                "${getDayName(date.weekday)} ",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0XFF263064),
                                ),
                              ),
                              Text(
                                formattedDate,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0XFF263064),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey.withOpacity(0.2),
                                      blurRadius: 12,
                                      spreadRadius: 8,
                                    )
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      profilePicUrl ?? defaultProfilePicUrl,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Hi ${name.split(" ")[0]}",
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 25,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0XFF263064),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      "Here is today's schedule",
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            sectionHeader(
                              "TODAY'S CLASSES",
                              context,
                              '/main/classes',
                            ),
                            todayClasses == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : todayClasses.isEmpty
                                    ? emptyContainer(
                                        "You have no classes today")
                                    : Container(
                                        height:
                                            todayClasses.length >= 2 ? 130 : 60,
                                        width: double.infinity,
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          children: todayClasses
                                              .map(
                                                (e) => classContainer(e),
                                              )
                                              .toList(),
                                        ),
                                      ),
                            SizedBox(height: 20),
                            sectionHeader(
                              "YOUR TASKS",
                              context,
                              '/main/tasks',
                            ),
                            allTasks == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : allTasks.isEmpty
                                    ? emptyContainer("You have no tasks")
                                    : Container(
                                        width: double.infinity,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: allTasks
                                                .map(
                                                  (e) => taskContainer(e),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ),
                            SizedBox(height: 20),
                            sectionHeader(
                              "YOUR ACHIEVEMENTS",
                            ),
                            allAchievements == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : allAchievements.isEmpty
                                    ? emptyContainer("You have no achievements")
                                    : Row(
                                        children: [
                                          for (var e in allAchievements)
                                            Card(
                                              elevation: 18,
                                              color: Colors.transparent,
                                              shape: CircleBorder(),
                                              child: Image.asset(
                                                'images/badges/$e.png',
                                                height: 60,
                                              ),
                                            ),
                                        ],
                                      ),
                            SizedBox(height: 20),
                            sectionHeader(
                              "YOUR SCHOOL",
                              context,
                            ),
                            schoolName == null
                                ? Column(
                                    children: [
                                      emptyContainer(
                                          "You haven't joined a school"),
                                      TextButton(
                                        child: Text("Join a school"),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return JoinSchoolForm(joinSchool);
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  )
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          blurRadius: 20,
                                          spreadRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(schoolName),
                                        Spacer(),
                                        TextButton(
                                          child: Text("Leave School"),
                                          onPressed: () {
                                            showAlert(
                                              context,
                                              "Leave School",
                                              "Are you sure you want to leave this school?",
                                              leaveSchool,
                                              "LEAVE",
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
