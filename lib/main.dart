import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:school_management/drawer.dart';
import 'package:school_management/screens/home_screen/homeScreen.dart';
import 'package:school_management/screens/profile_screen/profileScreen.dart';
import 'package:school_management/screens/about_screen/aboutScreen.dart';
import 'package:school_management/screens/admin_home_screen/adminHomeScreen.dart';
import 'package:school_management/screens/chat_screen/chatScreen.dart';

import 'package:school_management/screens/login_signup_select_screen/loginSignupSelectScreen.dart';
import 'package:school_management/screens/login_screen/loginScreen.dart';
import 'package:school_management/screens/signup_screen/signupScreen.dart';
import 'package:school_management/screens/signup_school_screen/signupSchoolScreen.dart';

import 'package:school_management/screens/calendar_screen/classesCalendarScreen.dart';
import 'package:school_management/screens/calendar_screen/tasksCalendarScreen.dart';

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat_logo');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);

  tz.initializeTimeZones();
  tz.setLocalLocation(
      tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));

  runApp(
    MaterialApp(
      title: 'EduLy',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (_) => LoginSignupSelectScreen(),
        '/login': (_) => LoginScreen(),
        '/signup': (_) => SignupScreen(),
        '/signup_school': (_) => SignupSchoolScreen(),
        '/about': (_) => AboutScreen(),
        '/main': (_) => BottomNavigator("teacher"),
        '/main/classes': (_) => ClassesCalendarScreen(),
        '/main/tasks': (_) => TasksCalendarScreen(),
        '/admin': (_) => BottomNavigator("school"),
        '/chat': (_) => BottomNavigator("both"),
      },
    ),
  );
}

class BottomNavigator extends StatefulWidget {
  final String type;

  BottomNavigator(this.type);

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
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState(() {
              _index = newIndex;
            });
          },
          children: widget.type == 'teacher'
              ? <Widget>[
                  HomeScreen(),
                  ProfileScreen(),
                  ChatScreen(),
                ]
              : <Widget>[
                  AdminHomeScreen(),
                  ChatScreen(),
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
        items: widget.type == "teacher"
            ? [
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
                BottomNavigationBarItem(
                  icon: _index == 2
                      ? Icon(Icons.chat_bubble)
                      : Icon(Icons.chat_bubble_outline),
                  label: "Chat",
                ),
              ]
            : [
                BottomNavigationBarItem(
                  icon: _index == 0
                      ? Icon(Icons.home_filled)
                      : Icon(Icons.home_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: _index == 1
                      ? Icon(Icons.chat_bubble)
                      : Icon(Icons.chat_bubble_outline),
                  label: "Chat",
                ),
              ],
      ),
    );
  }
}
