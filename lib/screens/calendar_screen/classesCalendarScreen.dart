import 'package:flutter/material.dart';
import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/calendarEvent.dart';
import 'package:school_management/screens/calendar_screen/components/calendarDay.dart';

class ClassesCalendarScreen extends StatelessWidget {
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  calendarDay("S", 14, false),
                                  calendarDay("M", 15, true),
                                  calendarDay("T", 16, false),
                                  calendarDay("W", 17, false),
                                  calendarDay("T", 18, false),
                                  calendarDay("F", 19, false),
                                  calendarDay("S", 20, false),
                                ],
                              ),
                            ),
                            calendarEvent(
                              "08:00",
                              "AM",
                              "1h",
                              "Geography - Class X",
                              "Natural Regions of the World",
                              "Room 10D, 5th Floor",
                            ),
                            calendarEvent(
                              "09:00",
                              "AM",
                              "1h mins",
                              "English Literature - Class IV",
                              "Figures of Speech",
                              "Room 3F, 1st Floor",
                            ),
                            calendarEvent(
                              "10:30",
                              "AM",
                              "1h 30 mins",
                              "Maths - Class III",
                              "Division",
                              "Room 2C, 1st Floor",
                            ),
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
