import 'package:flutter/material.dart';
import 'package:school_management/screens/profile_screen/components/tabBar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String name = "";
  User user = FirebaseAuth.instance.currentUser;
  String docId;

  List skills;
  List interests;
  List information;

  callback(List list1, List list2, List list3){
    skills = list1;
    interests = list2;
    information = list3;
  }

  @override
  void initState() {
    super.initState();
    users
        .where('email', isEqualTo: user.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          docId = doc.id;
          name = doc['name'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0XFFD4E7FE),
        padding: EdgeInsets.only(top: 24),
        alignment: Alignment.center,
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
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Color(0XFF263064),
                          ),
                        ),
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.withOpacity(0.2),
                                    blurRadius: 12,
                                    spreadRadius: 8,
                                  )
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://i.pravatar.cc/150?img=26",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          name,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF263064),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Teacher",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF263064),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: CustomTabBarView(callback),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFFebebeb),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: TextButton(
                          onPressed: () {
                            print(information);
                            //TODO: Array getting jumbled and skills and interets - handle null
                            users.doc(docId).update({
                              'information': {
                                "date_of_birth": information[1],
                                "age": information[2],
                                "blood_group": information[3],
                                "contact": information[4],
                                "adhaar_no": information[6],
                              },
                              'skills': skills,
                              'interests': interests,
                            });

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Success"),
                                  content:
                                      Text("Profile Updated Successfully!"),
                                  actions: [
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
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
      ),
    );
  }
}
