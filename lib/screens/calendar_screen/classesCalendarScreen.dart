import 'package:flutter/material.dart';

import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/calendarDay.dart';
import 'package:school_management/screens/calendar_screen/components/calendarEvent.dart';

import 'package:school_management/functions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClassesCalendarScreen extends StatefulWidget {
  @override
  _ClassesCalendarScreenState createState() => _ClassesCalendarScreenState();
}

class _ClassesCalendarScreenState extends State<ClassesCalendarScreen> {
  List days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];
  List dates = [];

  List classes;
  int selectedDate = DateTime.now().day;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String email = FirebaseAuth.instance.currentUser.email;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    for (var day in days) {
      int dayToAdd = DateTime.now().day + (days.indexOf(day) - DateTime.now().weekday);
      if(dayToAdd <= 0) dayToAdd += (getDaysInMonth() - 1); // -1 from getDaysInMonth because dayToAdd can be -1, so 31 + (-1) = 30
      dates.add(dayToAdd);
    }
    users
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data();

        setState(() {
          classes = data['classes'] == null ? [] : [...data['classes']];
        });
      });
    });
  }

  Widget noClassesText = Text(
    "You have no classes",
    style: TextStyle(
      decoration: TextDecoration.none,
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Color(0XFF263064),
    ),
  );

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(height: 10),
                    screenHeader(false, context),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: classes == null
                            ? noClassesText
                            : Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        for (var date in dates)
                                          calendarDay(
                                              days[dates.indexOf(date)][0],
                                              date,
                                              selectedDate == date, () {
                                            setState(() {
                                              selectedDate = date;
                                            });
                                          }),
                                      ],
                                    ),
                                  ),
                                  for (var i in classes)
                                    if (selectedDate ==
                                        dates[days.indexOf(i['day'])])
                                      CalendarEvent(
                                        i['time'].split(" ")[0],
                                        i['time'].split(" ")[1],
                                        i['name'],
                                        i['class'],
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
