import 'package:flutter/material.dart';

import 'package:school_management/screens/admin_home_screen/components/teacherContainer.dart';
import 'package:school_management/screens/home_screen/components/section_header.dart';
import 'package:school_management/screens/home_screen/components/empty_container.dart';

import 'package:school_management/functions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String schoolName;
  String schoolCode;
  String email = FirebaseAuth.instance.currentUser.email;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference schools =
      FirebaseFirestore.instance.collection('schools');

  List allTeachers;

  Future<String> getUrl(String email) async {
    String url;

    try {
      Reference ref =
          FirebaseStorage.instance.ref().child("profile_pictures/$email");
      url = (await ref.getDownloadURL()).toString();
    } on Exception catch (_) {
      url = null;
    }

    return url;
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
    schools
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data();
        setState(() {
          schoolName = data['name'];
          schoolCode = data['school_code'];
          allTeachers = [];
        });
      });
    }).whenComplete(() {
      users
          .where('school_code', isEqualTo: schoolCode)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        setState(() {
          allTeachers = [];
        });
        querySnapshot.docs.forEach((doc) async {
          var data = doc.data();
          data['profile_picture_url'] = await getUrl(data['email']);
          data['doc_id'] = doc.id;

          setState(() {
            allTeachers.add(data);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(DateTime.now().toString());
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
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  schoolName ?? "",
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
                                  child: SelectableText(
                                    "School Code - ${schoolCode ?? ""}",
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
                            ),
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
                              "TEACHERS",
                            ),
                            allTeachers == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : allTeachers.isEmpty
                                    ? emptyContainer(
                                        "No teachers in this school")
                                    : Column(
                                        children: allTeachers
                                            .map(
                                              (e) =>
                                                  teacherContainer(e, context),
                                            )
                                            .toList(),
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
