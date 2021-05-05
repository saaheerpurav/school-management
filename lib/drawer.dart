import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String name = "";
  String email = FirebaseAuth.instance.currentUser.email;
  String profilePicUrl;
  String defaultProfilePicUrl =
      "https://firebasestorage.googleapis.com/v0/b/school-management-4ac50.appspot.com/o/profile_pictures%2Fdefault_image.png?alt=media&token=dfee52bd-a093-4cf3-bbf4-4e5b0b5ed22f";

  void getUrl() async {
    String url;

    try {
      Reference ref =
          FirebaseStorage.instance.ref().child("profile_pictures/$email");
      url = (await ref.getDownloadURL()).toString();
    } on Exception catch (_) {
      url = FirebaseAuth.instance.currentUser.photoURL;
    }

    setState(() {
      profilePicUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();

    users
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          name = doc['name'];
        });
        getUrl();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        key: PageStorageKey('pagestore'),
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 220,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0XFFD4E7FE),
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
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
                            profilePicUrl ?? defaultProfilePicUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                      email,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF263064),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/main');
            },
          ),
          ListTile(
            title: Text('Classes'),
            leading: Icon(Icons.library_books),
            onTap: () {
              Navigator.pushNamed(context, '/main/classes');
            },
          ),
          ListTile(
            title: Text('Tasks'),
            leading: Icon(Icons.fact_check),
            onTap: () {
              Navigator.pushNamed(context, '/main/tasks');
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.account_box),
            onTap: () {},
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
            },
          ),
          ListTile(
            title: Text('About Us'),
            leading: Icon(Icons.info_outline),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}
