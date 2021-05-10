import 'package:flutter/material.dart';
import 'package:school_management/screens/login_screen/components/rounded_button.dart';

class LoginSignupSelectScreen extends StatefulWidget {
  @override
  _LoginSignupSelectScreenState createState() =>
      _LoginSignupSelectScreenState();
}

class _LoginSignupSelectScreenState extends State<LoginSignupSelectScreen> {
  selectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Who are you signing up as?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Teacher"),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/signup');
                },
              ),
              ListTile(
                title: Text("School Admin"),
                leading: Icon(Icons.school),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/signup_school');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
                "SIGNUP",
                context,
                selectionDialog,
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
