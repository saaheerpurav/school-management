import "package:flutter/material.dart";
import 'package:school_management/screens/profile_screen/components/columnBuilder.dart';
import 'package:school_management/screens/profile_screen/components/customTabHeader.dart';

class CustomTabBarView extends StatefulWidget {
  @override
  _TabBarViewState createState() => _TabBarViewState();
}

class _TabBarViewState extends State<CustomTabBarView>
    with TickerProviderStateMixin {
  /*TabController _tabController;
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

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(vsync: this, length: 3);

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
      "testuser@gmail.com",
      "1234 5678 9765"
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  bool fixedScroll;
  _scrollListener() {
    if (fixedScroll) {
      _scrollController.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      fixedScroll = _tabController.index == 2;
    });
  }

  Widget _buildCarousel() {
    return Stack(
      children: <Widget>[
        Placeholder(fallbackHeight: 100),
        Positioned.fill(child: Align(alignment: Alignment.center, child: Text('Slider'))),
      ],
    );
  }

  _buildTabContext(int lineCount) => Container(
    child: ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: lineCount,
      itemBuilder: (BuildContext context, int index) {
        return Text('some content');
      },
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            /*Container(
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
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFebebeb),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              //height: MediaQuery.of(context).size.height / 2.5,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ColumnBuilder(callback, information, "information", true),
                  ColumnBuilder(callback, skills, "skills"),
                  ColumnBuilder(callback, interests, "interests"),
                ],
              ),
            ),*/
            NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
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
                ];
              },
              body: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    ColumnBuilder(callback, information, "information", true),
                    ColumnBuilder(callback, skills, "skills"),
                    ColumnBuilder(callback, interests, "interests"),
                  ],
                ),
            ),
            /*Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFebebeb),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text("Profile Updated Successfully!"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }*/

  TabController _tabController;
  ScrollController _scrollController;

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
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);

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
      "testuser@gmail.com",
      "1234 5678 9765"
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFD4E7FE),
      body: Container(
        //padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
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
              ),
            ];
            /*
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFebebeb),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text("Profile Updated Successfully!"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
              ),
            ),
             */
          },
          body: Container(
            //color: Color(0xFFececec),
            decoration: BoxDecoration(
              color: Color(0xFFededed),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ColumnBuilder(callback, information, "information", true),
                ColumnBuilder(callback, skills, "skills"),
                ColumnBuilder(callback, interests, "interests"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
