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
    "21": [
      calendarEvent(
        "09:00",
        "AM",
        "1h mins",
        "English Literature - Class IV",
        "Figures of Speech",
        "Room 3F, 1st Floor",
      ),
    ],
    "22": [
      calendarEvent(
        "08:00",
        "AM",
        "1h",
        "Geography - Class X",
        "Natural Regions of the World",
        "Room 10D, 5th Floor",
      ),
    ],
    "23": [
      calendarEvent("08:00", "AM", "1h", "Geography - Class X",
          "Natural Regions of the World", "Room 10D, 5th Floor"),
      calendarEvent("09:30", "AM", "1h", "Maths - Class IV",
          "Squares and Cubes", "Room 3D, 2nd Floor"),
      calendarEvent("11:00", "AM", "1h", "Geography - Class X",
          "Natural Regions of the World", "Room 10D, 5th Floor"),
      calendarEvent("12:00", "AM", "1h", "Dance - Class VIII",
          "Salsa", "Hall, 2nd Floor"),
      calendarEvent("1:00", "PM", "1h", "Craft - Class III",
          "Creating Pen Stand", "Room 2C, 2nd Floor"),
    ],
    "24": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
    "25": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
    "26": [
      calendarEvent(
        "10:30",
        "AM",
        "1h 30 mins",
        "Maths - Class III",
        "Division",
        "Room 2C, 1st Floor",
      ),
    ],
    "27": [
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

  int selectedDate = 23;

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
                                  calendarDay("S", 21, selectedDate == 21, () {
                                    setState(() {
                                      selectedDate = 21;
                                    });
                                  }),
                                  calendarDay("M", 22, selectedDate == 22, () {
                                    setState(() {
                                      selectedDate = 22;
                                    });
                                  }),
                                  calendarDay("T", 23, selectedDate == 23, () {
                                    setState(() {
                                      selectedDate = 23;
                                    });
                                  }),
                                  calendarDay("W", 24, selectedDate == 24, () {
                                    setState(() {
                                      selectedDate = 24;
                                    });
                                  }),
                                  calendarDay("T", 25, selectedDate == 25, () {
                                    setState(() {
                                      selectedDate = 25;
                                    });
                                  }),
                                  calendarDay("F", 26, selectedDate == 26, () {
                                    setState(() {
                                      selectedDate = 26;
                                    });
                                  }),
                                  calendarDay("S", 27, selectedDate == 27, () {
                                    setState(() {
                                      selectedDate = 27;
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
