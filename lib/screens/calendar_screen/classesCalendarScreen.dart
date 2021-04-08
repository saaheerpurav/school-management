import 'package:flutter/material.dart';
import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/calendarEvent.dart';
import 'package:school_management/screens/calendar_screen/components/calendarDay.dart';

class ClassesCalendarScreen extends StatefulWidget {
  @override
  _ClassesCalendarScreenState createState() => _ClassesCalendarScreenState();
}

class _ClassesCalendarScreenState extends State<ClassesCalendarScreen> {
  Map<String, List> classes = {
    "4": [
      calendarEvent(
        "09:00",
        "AM",
        "1h mins",
        "English Literature - Class IV",
        "Figures of Speech",
        "Room 3F, 1st Floor",
      ),
    ],
    "5": [
      calendarEvent(
        "08:00",
        "AM",
        "1h",
        "Geography - Class X",
        "Natural Regions of the World",
        "Room 10D, 5th Floor",
      ),
    ],
    "6": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
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
    "9": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
    "10": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
  };

  int selectedDate = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      //color: Color(0xFFefefef),
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
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  calendarDay("S", 4, selectedDate == 4, () {
                                    setState(() {
                                      selectedDate = 4;
                                    });
                                  }),
                                  calendarDay("M", 5, selectedDate == 5, () {
                                    setState(() {
                                      selectedDate = 5;
                                    });
                                  }),
                                  calendarDay("T", 6, selectedDate == 6, () {
                                    setState(() {
                                      selectedDate = 6;
                                    });
                                  }),
                                  calendarDay("W", 7, selectedDate == 7, () {
                                    setState(() {
                                      selectedDate = 7;
                                    });
                                  }),
                                  calendarDay("T", 8, selectedDate == 8, () {
                                    setState(() {
                                      selectedDate = 8;
                                    });
                                  }),
                                  calendarDay("F", 9, selectedDate == 9, () {
                                    setState(() {
                                      selectedDate = 9;
                                    });
                                  }),
                                  calendarDay("S", 10, selectedDate == 10, () {
                                    setState(() {
                                      selectedDate = 10;
                                    });
                                  }),
                                ],
                              ),
                            ),
                            for (var i in classes[selectedDate.toString()]) i
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
