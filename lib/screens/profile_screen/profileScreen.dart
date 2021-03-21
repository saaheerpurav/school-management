import 'package:flutter/material.dart';
import 'package:school_management/screens/profile_screen/components/tabBar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFFD4E7FE),
      padding: EdgeInsets.only(top: 24),
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              blurRadius: 12,
                              spreadRadius: 8,
                            )
                          ],
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://i.pravatar.cc/150?img=26",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Jessie Reeves",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF263064),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Teacher",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: Color(0XFF263064),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: CustomTabBarView(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
