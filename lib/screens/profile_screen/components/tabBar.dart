import "package:flutter/material.dart";
import 'package:school_management/screens/profile_screen/components/columnBuilder.dart';
import 'package:school_management/screens/profile_screen/components/customTabHeader.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomTabBarView extends StatefulWidget {
  @override
  _TabBarViewState createState() => _TabBarViewState();

  final Function sendDataToParent;

  CustomTabBarView(this.sendDataToParent);
}

class _TabBarViewState extends State<CustomTabBarView>
    with TickerProviderStateMixin {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String name = "";

  TabController _tabController;
  ScrollController _scrollController;

  List skills;
  List interests;
  List information;

  int indexToPass = -1;

  changeLists(String value, String type, int index) {
    if (index != -1) {
      indexToPass = index;
    }
    setState(() {
      if (type == "information") {
        information[indexToPass] = value;
      } else if (type == "skills") {
        skills[indexToPass] = value;
      } else if (type == "interests") {
        interests[indexToPass] = value;
      }
    });

    widget.sendDataToParent(skills, interests, information);
  }

  addField(String type){
    setState(() {
      if (type == "skills") {
        skills.add("");
      } else if (type == "interests") {
        interests.add("");
      }
    });

    widget.sendDataToParent(skills, interests, information);
  }

  getData() {
    users
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data();
        var docInformation = data['information'];

        setState(() {
          if (docInformation == null) {
            information = [
              data['name'] ?? "",
              "",
              "",
              "",
              "",
              data['email'] ?? "",
              "",
            ];
          }

          else{
            information = [
              data['name'] ?? "",
              docInformation['date_of_birth'] ?? "",
              docInformation['age'] ?? "",
              docInformation['blood_group'] ?? "",
              docInformation['contact'] ?? "",
              data['email'] ?? "",
              docInformation['adhaar_no'] ?? "",
            ];
          }

          skills = data['skills'] ?? [];
          interests = data['interests'] ?? [];

          widget.sendDataToParent(skills, interests, information);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);

    getData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFD4E7FE),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: information == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, value) {
                  return [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: TabBar(
                          isScrollable: true,
                          unselectedLabelStyle: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFFACB3BF),
                            fontSize: 17,
                          ),
                          labelStyle: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 17,
                          ),
                          indicatorColor: Color(0XFFFFAC81),
                          labelColor: Colors.black,
                          indicatorWeight: 3,
                          controller: _tabController,
                          tabs: [
                            customTabHeader("INFORMATION"),
                            customTabHeader("SKILLS"),
                            customTabHeader("INTERESTS"),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  //color: Color(0xFFececec),
                  decoration: BoxDecoration(
                    color: Color(0xFFededed),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      ColumnBuilder(changeLists, addField, information, "information", true),
                      ColumnBuilder(changeLists, addField, skills, "skills"),
                      ColumnBuilder(changeLists, addField, interests, "interests"),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
