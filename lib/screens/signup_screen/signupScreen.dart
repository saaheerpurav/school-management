import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_input.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:school_management/functions.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

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
    Function createAccount = () async {
      users
          .add({
            'name': name,
            'email': email,
          })
          .then(
            showAlert(
              context,
              "Success",
              "Successfully Signed Up!",
              () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/main');
              },
            ),
          )
          .catchError((error) => print("Failed to add user: $error"));
    };

    Future signInWithGoogle() async {
      //_googleSignIn.signOut();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        email = user.user.email;
        name = user.user.displayName;
      });
      createAccount();
    }

    Future signUpWithEmailPassword() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((_) {
          createAccount();
        });
      } on FirebaseAuthException catch (e) {
        showAlert(context, "Error", e.message, () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        debugPrint(e);
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
              roundedButton("SIGNUP", context, signUpWithEmailPassword,
                  Color(0xFF6F35A5)),
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
              Center(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextButton(
                    onPressed: signInWithGoogle,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Image.asset(
                              'images/google.png',
                              width: 20,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Sign up with Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          )
        ],
      ),
    );
  }
}
