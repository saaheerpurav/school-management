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
  List skills = [
    "Geography",
    "English",
    "Maths - Basics",
  ];

  List interests = [
    "Craft",
    "Dance",
  ];

  List information = [
    "Jessie Reeves",
    "1st January, 1990",
    "31",
    "A+",
    "987654321",
    "user@email.com",
    "1234 5678 9765"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
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
                customTabHeader("SKILLS"),
                customTabHeader("INTERESTS"),
                customTabHeader("INFORMATION"),
              ],
            ),
          ),
          

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFebebeb),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              height: MediaQuery.of(context).size.height / 2,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  columnsBuilder(skills),
                  columnsBuilder(interests),
                  columnsBuilder(information, true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
