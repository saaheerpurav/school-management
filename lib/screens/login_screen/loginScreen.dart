import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_input.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
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
            right: 0,
            child: Image.asset(
              'images/login_bottom.png',
              width: 100,
              alignment: Alignment.bottomRight,
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(height: 100),
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
              SizedBox(height: 50),
              Image.asset('images/login.png', height: 180),
              SizedBox(height: MediaQuery.of(context).size.height/5),
              RoundedInput("Email", Icons.person_rounded),
              SizedBox(height: 15),
              RoundedInput("Password", Icons.lock),
              SizedBox(height: 15),
              roundedButton("LOGIN", context, ()=>Navigator.of(context).pushNamed("/main"), Color(0xFF6F35A5)),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Don't have an Account? Sign Up",
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
            ],
          )
        ],
      ),
    );
  }
}
