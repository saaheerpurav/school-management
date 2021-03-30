import 'package:flutter/material.dart';

Widget calendarEvent(
  String timeNum,
  String timeType,
  String duration,
  String title,
  var topic,
  String room, [
  Widget alertDialog,
  String status = "",
  bool isTasks = false,
  Color taskColor,
  BuildContext context,
]) {
  return Container(
    margin: EdgeInsets.only(top: 20, bottom: 10),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 20,
              height: 10,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Color(0XFFffd633),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            Text(
              timeNum,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: Color(0XFF263064),
              ),
            ),
            Text(
              " $timeType",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Text(
              duration,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(left: 30, right: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: isTasks ? taskColor.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isTasks ? Colors.white : Color(0xFFeeeeee),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Color(0XFF263064),
                      ),
                    ),
                  ),
                  status == "Complete"
                      ? Icon(
                          Icons.done,
                          color: taskColor,
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                ],
              ),
              SizedBox(height: 7),
              topic == null
                  ? Container(
                      width: 0,
                      height: 0,
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 7),
                      child: Text(
                        topic,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
              status == null
                  ? Container(
                      width: 0,
                      height: 0,
                    )
                  : Text(
                      "Status: $status",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey,
                      ),
                    ),
              Row(
                children: <Widget>[
                  isTasks
                      ? Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: taskColor,
                          ),
                        )
                      : Icon(
                          Icons.location_on_sharp,
                          color: Colors.grey.withOpacity(0.7),
                          size: 17,
                        ),
                  Container(
                    padding: EdgeInsets.only(left: 7),
                    width: 150,
                    child: Text(
                      room,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Spacer(),
                  isTasks
                      ? TextButton(
                          child: Text("EDIT"),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alertDialog;
                              },
                            );
                          },
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
