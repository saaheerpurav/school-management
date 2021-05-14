import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_input.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';
import 'package:school_management/screens/signup_screen/components/google_button.dart';
import 'package:school_management/functions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  checkWhereExists(String collection) async {
    bool exists = false;
    await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc.data()['email'] == email)
          exists = true;
        else
          exists = false;
      });
    });
    return exists;
  }

  @override
  Widget build(BuildContext context) {
    Future signInWithEmailPassword() async {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((_) async {
          if (await checkWhereExists('users')) {
            Navigator.of(context).pushNamed('/main');
          } else if (await checkWhereExists('schools')) {
            Navigator.of(context).pushNamed('/admin');
          }
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

    Future signInWithGoogle() async {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        email = user.user.email;
      });
      Navigator.of(context).pushNamed('/main');
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'images/main_top.png',
              width: 100,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'images/login_bottom.png',
              width: 100,
              alignment: Alignment.bottomRight,
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(height: 50),
              Center(
                child: Text(
                  "LOGIN",
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
              SizedBox(height: 25),
              Image.asset('images/login.png', height: 180),
              SizedBox(height: 100),
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
              roundedButton(
                  "LOGIN", context, signInWithEmailPassword, Color(0xFF6F35A5)),
              SizedBox(height: 20),
              googleButton(signInWithGoogle, "in"),
              SizedBox(height: 15),
            ],
          )
        ],
      ),
    );
  }
}
