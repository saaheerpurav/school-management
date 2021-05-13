import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_input.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:school_management/functions.dart';

class SignupSchoolScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupSchoolScreenState();
  }
}

class _SignupSchoolScreenState extends State<SignupSchoolScreen> {
  CollectionReference schools =
      FirebaseFirestore.instance.collection('schools');

  String name = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    Function createAccount = () async {
      schools.add({
        'name': name,
        'email': email,
      }).then(
        (value) {
          String docId = value.id;
          String schoolCode = docId.toLowerCase().substring(0, 9);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Successfully Signed Up!"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Your School Code is"),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        schoolCode,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF263064),
                        ),
                      ),
                    ),
                    Text(
                      "Please share it with your teachers so they can join your school.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      schools.doc(docId).update({
                        'school_code': schoolCode,
                      });
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/admin');
                    },
                  ),
                ],
              );
            },
          );
        },
      ).catchError((error) => print("Failed to add school: $error"));
    };

    Future signUpWithEmailPassword() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((_) {
          createAccount();
        });
      } on FirebaseAuthException catch (e) {
        String message;

        if (e.message.contains("empty")) {
          message = "Please enter Email / Password";
        } else if (e.message.contains("Unable to resolve host")) {
          message = "No Internet Connection";
        } else {
          message = e.message;
        }

        showAlert(context, "Error", message, () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }

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
                  "SCHOOL SIGNUP",
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
              Image.asset('images/welcome.png', height: 200),
              SizedBox(height: 50),
              RoundedInput("School Name", Icons.school, (value) {
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
              roundedButton("SIGNUP", context, signUpWithEmailPassword,
                  Color(0xFF6F35A5)),
              SizedBox(height: 15),
            ],
          )
        ],
      ),
    );
  }
}
