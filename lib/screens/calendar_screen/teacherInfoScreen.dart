import 'package:flutter/material.dart';

import 'package:school_management/screens/calendar_screen/components/screenHeader.dart';
import 'package:school_management/screens/calendar_screen/components/teacherInfoRow.dart';
import 'package:school_management/screens/home_screen/components/section_header.dart';

import 'package:school_management/functions.dart';

class TeacherInfoScreen extends StatefulWidget {
  final Map data;

  TeacherInfoScreen(this.data);

  @override
  _TeacherInfoScreenState createState() => _TeacherInfoScreenState();
}

class _TeacherInfoScreenState extends State<TeacherInfoScreen> {
  String defaultProfilePicUrl =
      "https://firebasestorage.googleapis.com/v0/b/school-management-4ac50.appspot.com/o/profile_pictures%2Fdefault_image.png?alt=media&token=dfee52bd-a093-4cf3-bbf4-4e5b0b5ed22f";

  @override
  Widget build(BuildContext context) {
    Map data = widget.data;
    /*data['information'].entries.map((e){
      debugPrint(e.value);
    });*/

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
                            sectionHeader(
                              "INFORMATION",
                            ),
                            teacherInfoRow("Contact: ", data['information']["contact"]),
                            teacherInfoRow("Age: ", data['information']["age"]),
                            teacherInfoRow("Date Of Birth: ", data['information']["date_of_birth"]),
                            teacherInfoRow("Blood Group: ", data['information']["blood_group"]),
                            teacherInfoRow("Aadhaar Number: ", data['information']["aadhaar_no"]),
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
