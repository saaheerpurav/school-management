import 'package:flutter/material.dart';
import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/calendarDay.dart';
import 'package:school_management/screens/calendar_screen/components/calendarEvent.dart';

class ClassesCalendarScreen extends StatefulWidget {
  @override
  _ClassesCalendarScreenState createState() => _ClassesCalendarScreenState();
}

class _ClassesCalendarScreenState extends State<ClassesCalendarScreen> {
  /*Map<String, List> classes = {
    "2": [
      calendarEvent(
        "09:00",
        "AM",
        "1h mins",
        "English Literature - Class IV",
        "Figures of Speech",
        "Room 3F, 1st Floor",
      ),
    ],
    "3": [
      calendarEvent(
        "08:00",
        "AM",
        "1h",
        "Geography - Class X",
        "Natural Regions of the World",
        "Room 10D, 5th Floor",
      ),
    ],
    "4": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
    "5": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
    "6": [
      calendarEvent(
        "08:00",
        "AM",
        "1h",
        "Geography - Class X",
        "Natural Regions of the World",
        "Room 10D, 5th Floor",
      ),
      calendarEvent(
        "09:30",
        "AM",
        "1h",
        "Maths - Class IV",
        "Squares and Cubes",
        "Room 3D, 2nd Floor",
      ),
      calendarEvent(
        "11:00",
        "AM",
        "1h",
        "Geography - Class X",
        "Natural Regions of the World",
        "Room 10D, 5th Floor",
      ),
      calendarEvent(
        "12:00",
        "AM",
        "1h",
        "Dance - Class VIII",
        "Salsa",
        "Hall, 2nd Floor",
      ),
      calendarEvent(
        "1:00",
        "PM",
        "1h",
        "Craft - Class III",
        "Creating Pen Stand",
        "Room 2C, 2nd Floor",
      ),
    ],
    "7": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
    "8": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
  };*/
  Map<String, List> classes;
  int selectedDate = 6;

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
                            ? Text(
                                "You have no classes",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF263064),
                                ),
                              )
                            : Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        calendarDay("S", 2, selectedDate == 2,
                                            () {
                                          setState(() {
                                            selectedDate = 2;
                                          });
                                        }),
                                        calendarDay("M", 3, selectedDate == 3,
                                            () {
                                          setState(() {
                                            selectedDate = 3;
                                          });
                                        }),
                                        calendarDay("T", 4, selectedDate == 4,
                                            () {
                                          setState(() {
                                            selectedDate = 4;
                                          });
                                        }),
                                        calendarDay("W", 5, selectedDate == 5,
                                            () {
                                          setState(() {
                                            selectedDate = 5;
                                          });
                                        }),
                                        calendarDay("T", 6, selectedDate == 6,
                                            () {
                                          setState(() {
                                            selectedDate = 6;
                                          });
                                        }),
                                        calendarDay("F", 7, selectedDate == 7,
                                            () {
                                          setState(() {
                                            selectedDate = 7;
                                          });
                                        }),
                                        calendarDay("S", 8, selectedDate == 8,
                                            () {
                                          setState(() {
                                            selectedDate = 8;
                                          });
                                        }),
                                      ],
                                    ),
                                  ),
                                  for (var i
                                      in classes[selectedDate.toString()])
                                    i
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
