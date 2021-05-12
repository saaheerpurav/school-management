import 'package:flutter/material.dart';

import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/teacherInfoRow.dart';
import 'package:school_management/screens/calendar_screen/components/classScheduleForm.dart';

import 'package:school_management/screens/home_screen/components/section_header.dart';
import 'package:school_management/screens/home_screen/components/class_container.dart';

import 'package:school_management/data/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherInfoScreen extends StatefulWidget {
  final Map data;

  TeacherInfoScreen(this.data);

  @override
  _TeacherInfoScreenState createState() => _TeacherInfoScreenState();
}

class _TeacherInfoScreenState extends State<TeacherInfoScreen> {
  String defaultProfilePicUrl =
      "https://firebasestorage.googleapis.com/v0/b/school-management-4ac50.appspot.com/o/profile_pictures%2Fdefault_image.png?alt=media&token=dfee52bd-a093-4cf3-bbf4-4e5b0b5ed22f";

  int skillColorIndex = 0;
  int interestColorIndex = 0;

  List<Widget> skills = [];
  List<Widget> interests = [];

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  scheduleClass(Map data) {
    users.doc(widget.data['doc_id']).update({
      'classes': FieldValue.arrayUnion([data]),
    }).whenComplete(() {
      setState(() {
        if (widget.data['classes'] == null) widget.data['classes'] = [];
        widget.data['classes'].add(data);
      });
    });
  }

  giveAchievement(String type) {
    users.doc(widget.data['doc_id']).update({
      'achievements': FieldValue.arrayUnion([type]),
    }).whenComplete(() {
      setState(() {
        if (widget.data['achievements'] == null)
          widget.data['achievements'] = [];
        widget.data['achievements'].add(type);
      });
      Navigator.of(context).pop();
    });
  }

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
    for (var item in widget.data['skills']) {
      setState(() {
        skillColorIndex != colors.length - 1
            ? skillColorIndex += 1
            : skillColorIndex = 0;
        skills.add(skillInterestItem(item, colors[skillColorIndex]));
      });
    }
    for (var item in widget.data['interests']) {
      setState(() {
        interestColorIndex != colors.length - 1
            ? interestColorIndex += 1
            : interestColorIndex = 0;
        interests.add(skillInterestItem(
            item, colors[colors.length - 1 - interestColorIndex]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map data = widget.data;

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
                    screenHeader(true, context, "Teacher"),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 20, left: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: 50,
                                  height: 50,
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
                                        data['profile_picture_url'] ??
                                            defaultProfilePicUrl,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data['name'],
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
                                        data['email'],
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
                            SizedBox(height: 10),
                            if (data['information'] != null)
                              Column(
                                children: [
                                  teacherInfoRow("Contact: ",
                                      data['information']["contact"]),
                                  teacherInfoRow(
                                      "Age: ", data['information']["age"]),
                                  teacherInfoRow("Date Of Birth: ",
                                      data['information']["date_of_birth"]),
                                  teacherInfoRow("Blood Group: ",
                                      data['information']["blood_group"]),
                                  teacherInfoRow("Aadhaar Number: ",
                                      data['information']["aadhaar_no"]),
                                ],
                              ),
                            if (skills.isNotEmpty) SizedBox(height: 20),
                            if (skills.isNotEmpty) sectionHeader("SKILLS"),
                            Container(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: skills,
                                ),
                              ),
                            ),
                            if (interests.isNotEmpty) SizedBox(height: 20),
                            if (interests.isNotEmpty)
                              sectionHeader("INTERESTS"),
                            Container(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: interests,
                                ),
                              ),
                            ),
                            if (data['classes'] != null)
                              Column(
                                children: [
                                  SizedBox(height: 20),
                                  sectionHeader("CLASSES"),
                                  Container(
                                    height:
                                        data['classes'].length >= 2 ? 130 : 60,
                                    width: double.infinity,
                                    child: ListView(
                                        padding: EdgeInsets.only(right: 10),
                                        children: [
                                          for (var e in data['classes'])
                                            classContainer(e)
                                        ]),
                                  ),
                                ],
                              ),
                            if (data['achievements'] != null)
                              Column(
                                children: [
                                  SizedBox(height: 20),
                                  sectionHeader("ACHIEVEMENTS"),
                                  Row(
                                    children: [
                                      for (var e in data['achievements'])
                                        Card(
                                          elevation: 18.0,
                                          color: Colors.transparent,
                                          shape: CircleBorder(),
                                          child: Image.asset(
                                            'images/badges/$e.png',
                                            height: 60,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  child: Text("Give Achievement"),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Select an achievement",
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                child: Image.asset(
                                                  'images/badges/best_teacher.png',
                                                  width: 50,
                                                ),
                                                onPressed: () =>
                                                    giveAchievement(
                                                        "best_teacher"),
                                              ),
                                              TextButton(
                                                child: Image.asset(
                                                  'images/badges/star_teacher.png',
                                                  width: 50,
                                                ),
                                                onPressed: () =>
                                                    giveAchievement(
                                                        "star_teacher"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                TextButton(
                                  child: Text("Schedule Class"),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ClassScheduleForm(scheduleClass);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
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
