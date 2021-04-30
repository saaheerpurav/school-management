import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_input.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';
import 'package:school_management/screens/signup_screen/components/icon_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:school_management/functions.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String name = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    Function signUp = () async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((_) {
          users
              .add({
                'name': name,
                'email': email,
              })
              .then(
                showAlert(
                  context,
                  "Success",
                  "User added successfully!",
                  () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/main');
                  },
                ),
              )
              .catchError((error) => print("Failed to add user: $error"));
        });
      } on FirebaseAuthException catch (e) {
        showAlert(context, "Error", e.message, () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        debugPrint(e);
      }
    };

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'images/signup_top.png',
              width: 100,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'images/main_bottom.png',
              width: 50,
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(height: 50),
              Center(
                child: Text(
                  "SIGNUP",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF263064),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Image.asset('images/signup.png', height: 200),
              SizedBox(height: 50),
              RoundedInput("Name", Icons.person_rounded, (value) {
                setState(() {
                  name = value;
                });
              }),
              SizedBox(height: 15),
              RoundedInput("Email", Icons.email, (value) {
                setState(() {
                  email = value;
                });
              }),
              SizedBox(height: 15),
              RoundedInput("Password", Icons.lock, (value) {
                setState(() {
                  password = value;
                });
              }),
              SizedBox(height: 15),
              roundedButton("SIGNUP", context, signUp, Color(0xFF6F35A5)),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Already have an Account? Sign In",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6F35A5),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 100,
                    height: 2,
                    color: Color(0xFFF1E6FF),
                  ),
                  Center(
                    child: Text(
                      "OR",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6F35A5),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 100,
                    height: 2,
                    color: Color(0xFFF1E6FF),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  iconButton('images/facebook.png'),
                  SizedBox(width: 30),
                  iconButton('images/twitter.png'),
                  SizedBox(width: 30),
                  iconButton('images/google-plus.png'),
                  Spacer(),
                ],
              ),
              SizedBox(height: 15),
            ],
          )
        ],
      ),
    );
  }
}
