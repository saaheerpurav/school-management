import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_input.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';
import 'package:school_management/screens/signup_screen/components/icon_button.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 20),
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
              SizedBox(height: 30),
              Image.asset('images/signup.png', height: 200),
              SizedBox(height: 30),
              roundedInput("Email", Icons.person_rounded),
              SizedBox(height: 15),
              roundedInput("Password", Icons.lock),
              SizedBox(height: 15),
              roundedButton("SIGNUP", context, "/main", Color(0xFF6F35A5)),
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
