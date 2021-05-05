import 'package:flutter/material.dart';
import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/calendarDay.dart';

class ClassesCalendarScreen extends StatefulWidget {
  @override
  _ClassesCalendarScreenState createState() => _ClassesCalendarScreenState();
}

class _ClassesCalendarScreenState extends State<ClassesCalendarScreen> {
  Map<String, List> classes;
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
                                        calendarDay("S", 4, selectedDate == 4,
                                            () {
                                          setState(() {
                                            selectedDate = 4;
                                          });
                                        }),
                                        calendarDay("M", 5, selectedDate == 5,
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
                                        calendarDay("W", 7, selectedDate == 7,
                                            () {
                                          setState(() {
                                            selectedDate = 7;
                                          });
                                        }),
                                        calendarDay("T", 8, selectedDate == 8,
                                            () {
                                          setState(() {
                                            selectedDate = 8;
                                          });
                                        }),
                                        calendarDay("F", 9, selectedDate == 9,
                                            () {
                                          setState(() {
                                            selectedDate = 9;
                                          });
                                        }),
                                        calendarDay("S", 10, selectedDate == 10,
                                            () {
                                          setState(() {
                                            selectedDate = 10;
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
