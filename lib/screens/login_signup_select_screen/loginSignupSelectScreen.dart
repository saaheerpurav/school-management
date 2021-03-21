import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_input.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';

class LoginSignupSelectScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginSignupSelectScreenState();
  }
}

class _LoginSignupSelectScreenState extends State<LoginSignupSelectScreen> {
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
              'images/main_top.png',
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
                  "School Management",
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
              Spacer(),
              SizedBox(height: 30),
              Image.asset('images/welcome.png', height: 250),
              SizedBox(height: 30),
              roundedButton("LOGIN", context, "/login", Color(0xFF6F35A5)),
              SizedBox(height: 15),
              roundedButton("SIGNUP", context, "/signup", Color(0xFFF1E6FF), Color(0XFF263064)),
              SizedBox(height: 15),
            ],
          )
        ],
      ),
    );
  }
}
