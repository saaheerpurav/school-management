import 'package:flutter/material.dart';
import 'package:school_management/drawer.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.white,
            child: ListView(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: 1000,
                      height: 350,
                      padding: EdgeInsets.only(bottom: 100),
                      decoration: BoxDecoration(
                        color: Color(0XFFD4E7FE),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                            200,
                            50,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              spreadRadius: 5,
                              color: Color(0XFFa2bbdb),
                            )
                          ],
                        ),
                        child: Image.asset(
                          'images/logo.png',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: TextButton.icon(
                        icon: Icon(
                          Icons.menu,
                          color: Color(0XFF263064),
                        ),
                        onPressed: ()=>Scaffold.of(context).openDrawer(),
                        label: Container(
                          width: 0,
                          height: 0,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 170),
                      child: Container(
                        width: 150,
                        height: 150,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(
                          'images/pic.png',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Center(
                  child: Text(
                    "${"EduLy\n"}A School Management App${"\nBy Saaheer Purav"}",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF263064),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "This app is made as a project for the WhiteHat Jr 18 under 18 Fellowship’s mentorship program.",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          );
        }
      ),
    );
  }
}
