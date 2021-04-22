import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';

class LoginSignupSelectScreen extends StatelessWidget {
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
          Column(
            children: <Widget>[
              SizedBox(height: 100),
              Image.asset('images/logo.png'),
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              roundedButton("LOGIN", context, ()=>Navigator.of(context).pushNamed('/login'), Color(0xFF6F35A5)),
              SizedBox(height: 15),
              roundedButton("SIGNUP", context, ()=>Navigator.of(context).pushNamed('/signup'), Color(0xFFF1E6FF),
                  Color(0XFF263064)),
            ],
          )
        ],
      ),
    );
  }
}
