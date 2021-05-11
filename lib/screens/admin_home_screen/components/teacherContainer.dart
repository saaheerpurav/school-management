import 'package:flutter/material.dart';
import 'package:school_management/screens/calendar_screen/teacherInfoScreen.dart';

Widget teacherContainer(Map data, BuildContext context) {
  String defaultProfilePicUrl =
      "https://firebasestorage.googleapis.com/v0/b/school-management-4ac50.appspot.com/o/profile_pictures%2Fdefault_image.png?alt=media&token=dfee52bd-a093-4cf3-bbf4-4e5b0b5ed22f";

  return Container(
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          blurRadius: 12,
          spreadRadius: 1,
        )
      ],
    ),
    child: TextButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TeacherInfoScreen(data)),
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.black,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          Colors.grey.withOpacity(0.2),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  data['profile_picture_url'] ?? defaultProfilePicUrl,
                ),
              ),
            ),
          ),
          Text(data['name']),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
    ),
  );
}
