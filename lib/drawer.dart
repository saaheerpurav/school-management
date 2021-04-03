import 'package:flutter/material.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 220,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0XFFD4E7FE),
            ),
            child: Column(
              children: <Widget>[
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
                    "user@email.com",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF263064),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: Text('Home'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/main');
          },
        ),
        ListTile(
          title: Text('Classes'),
          leading: Icon(Icons.library_books),
          onTap: () {
            Navigator.pushNamed(context, '/main/classes');
          },
        ),
        ListTile(
          title: Text('Tasks'),
          leading: Icon(Icons.fact_check),
          onTap: () {
            Navigator.pushNamed(context, '/main/tasks');
          },
        ),
        ListTile(
          title: Text('Profile'),
          leading: Icon(Icons.account_box),
          onTap: () {
          },
        ),
        ListTile(
          title: Text('Logout'),
          leading: Icon(Icons.logout),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
          },
        ),
        ListTile(
          title: Text('About Us'),
          leading: Icon(Icons.info_outline),
          onTap: () {
            Navigator.pushNamed(context, '/about');
          },
        ),
      ],
    ),
  );
}
