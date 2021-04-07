import 'package:flutter/material.dart';
import 'components/section_header.dart';
import 'components/task_container.dart';
import 'components/class_container.dart';

import 'package:school_management/data/tasks.dart';
import 'package:school_management/data/colors.dart';

class HomeScreen extends StatelessWidget {
  List<Map> allTasks = tasks(colors);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    debugPrint(formattedDate);

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
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer(),
                                icon: Icon(
                                  Icons.menu,
                                  color: Color(0XFF263064),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Tue ",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0XFF263064),
                                ),
                              ),
                              Text(
                                "23 Mar",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 15.0,
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
                                    image: NetworkImage(
                                      'https://i.pravatar.cc/150?img=26',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Hi Jessie",
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 25,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        color: Color(0XFF263064)),
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
                            classContainer(
                              "Geography - Class X",
                              false,
                              "08:00",
                              "Room 10D, 5th Floor",
                            ),
                            classContainer(
                              "English Literature - Class IV",
                              true,
                              "09:00",
                              "Room 3F, 1st Floor",
                            ),
                            sectionHeader(
                              "YOUR TASKS",
                              context,
                              '/main/tasks',
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: allTasks
                                    .map(
                                      (e) => taskContainer(e),
                                    )
                                    .toList(),
                              ),
                            ),
                            SizedBox(height: 20),
                            sectionHeader(
                              "YOUR ACHIEVEMENTS",
                              context,
                            ),
                            Row(
                              children: [
                                Card(
                                  elevation: 18.0,
                                  color: Colors.transparent,
                                  shape: CircleBorder(),
                                  child: Image.asset(
                                    'images/badges/best_teacher.png',
                                    height: 80,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Card(
                                  elevation: 18.0,
                                  color: Colors.transparent,
                                  shape: CircleBorder(),
                                  child: Image.asset(
                                    'images/badges/star_teacher.png',
                                    height: 80,
                                  ),
                                ),
                              ],
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
