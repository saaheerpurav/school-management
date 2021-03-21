import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart';

import 'package:school_management/screens/home_screen/homeScreen.dart';
import 'package:school_management/screens/login_screen/loginScreen.dart';
import 'package:school_management/screens/profile_screen/profileScreen.dart';
import 'package:school_management/screens/signup_screen/signupScreen.dart';
import 'package:school_management/screens/login_signup_select_screen/loginSignupSelectScreen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'School Management',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (_) => LoginSignupSelectScreen(),
        '/login': (_) => LoginScreen(),
        '/signup': (_) => SignupScreen(),
        '/main': (_) => BottomNavigator(),
      },
    ),
  );
}

class BottomNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNavigatorState();
  }
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _index = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_index) {
      case 0:
        child = HomeScreen();
        break;
      case 1:
        child = ProfileScreen();
        break;
    }

    return Scaffold(
      //body: child,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _index = index);
          },
          children: <Widget>[
            HomeScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() {
          _index = newIndex;
          _pageController.animateToPage(
            newIndex,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }),
        currentIndex: _index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color(0xFFF0F0F0),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
        items: [
          BottomNavigationBarItem(
            icon: _index == 0
                ? Icon(Icons.home_filled)
                : Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _index == 1
                ? Icon(Icons.account_box)
                : Icon(Icons.account_box_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
