import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';

class LoginSignupSelectScreen extends StatefulWidget {
  @override
  _LoginSignupSelectScreenState createState() =>
      _LoginSignupSelectScreenState();
}

class _LoginSignupSelectScreenState extends State<LoginSignupSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
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
          Column(
            children: <Widget>[
              SizedBox(height: 100),
              Image.asset(
                'images/logo.png',
                height: 200,
              ),
              Spacer(),
              roundedButton(
                "LOGIN",
                context,
                () => Navigator.of(context).pushNamed('/login'),
                Color(0xFF6F35A5),
              ),
              SizedBox(height: 15),
              roundedButton(
                "SIGNUP AS TEACHER",
                context,
                () => Navigator.of(context).pushNamed('/signup'),
                Color(0xFFF1E6FF),
                Color(0XFF263064),
              ),
              SizedBox(height: 15),
              roundedButton(
                "SIGNUP AS SCHOOL",
                context,
                () => Navigator.of(context).pushNamed('/signup_school'),
                Color(0xFFF1E6FF),
                Color(0XFF263064),
              ),
              SizedBox(height: 70),
            ],
          )
        ],
      ),
    );
  }
}
