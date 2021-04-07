import "package:flutter/material.dart";
import 'package:school_management/screens/profile_screen/components/columnBuilder.dart';
import 'package:school_management/screens/profile_screen/components/customTabHeader.dart';

class CustomTabBarView extends StatefulWidget {
  @override
  _TabBarViewState createState() => _TabBarViewState();
}

class _TabBarViewState extends State<CustomTabBarView>
    with TickerProviderStateMixin {
  TabController _tabController;
  List skills;
  List interests;
  List information;

  int indexToPass = -1;

  callback(String value, String type, int index) {
    if (index != -1) {
      indexToPass = index;
    }
    setState(() {
      if (type == "information") {
        information[indexToPass] = value;
      } else if (type == "skills") {
        skills[indexToPass] = value;
      } else if (type == "interests") {
        interests[indexToPass] = value;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);

    skills = [
      "Geography",
      "English",
      "Maths - Basics",
    ];

    interests = [
      "Craft",
      "Dance",
    ];

    information = [
      "Jessie Reeves",
      "1st January, 1990",
      "31",
      "A+",
      "987654321",
      "user@email.com",
      "1234 5678 9765"
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TabBar(
              isScrollable: true,
              unselectedLabelStyle: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                color: Color(0XFFACB3BF),
                fontSize: 17,
              ),
              labelStyle: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 17,
              ),
              indicatorColor: Color(0XFFFFAC81),
              labelColor: Colors.black,
              indicatorWeight: 3,
              controller: _tabController,
              tabs: [
                customTabHeader("INFORMATION"),
                customTabHeader("SKILLS"),
                customTabHeader("INTERESTS"),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFebebeb),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 2 + 8,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      ColumnBuilder(callback, information, "information", true),
                      ColumnBuilder(callback, skills, "skills"),
                      ColumnBuilder(callback, interests, "interests"),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Color(0xFFebebeb),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextButton(
                      onPressed: () {
                        print(interests);
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
