import 'package:flutter/material.dart';

Widget taskContainer(Map data) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.all(10),
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      color: data['color'].withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Text(
                data['task'],
                textDirection: TextDirection.ltr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF263064),
                ),
              ),
            ),
            data['status'] == "Complete"
                ? Icon(
                    Icons.done,
                    color: data['color'],
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ],
        ),
        SizedBox(height: 5),
        data['description'] != null
            ? Text(
                data['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey,
                ),
              )
            : Container(
                width: 0,
                height: 0,
              ),
        SizedBox(height: 5),
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 6,
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: data['color'],
              ),
            ),
            Text(
              data['deadlineMessage'],
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Color(0XFF263064),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
