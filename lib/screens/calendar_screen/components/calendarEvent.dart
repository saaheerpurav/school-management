import 'package:flutter/material.dart';

class CalendarEvent extends StatelessWidget {
  final String timeNum;
  final String timeType;
  final String title;
  final String topic;
  final String room;
  final Widget alertDialog;
  final Widget deleteBox;
  final String status;
  final bool isTasks;
  final Color taskColor;

  CalendarEvent(this.timeNum, this.timeType, this.title,
      [this.topic,
      this.room,
      this.alertDialog,
      this.deleteBox,
      this.status = "",
      this.isTasks = false,
      this.taskColor]);

  @override
  Widget build(BuildContext context) {
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
                color: isTasks ? Colors.white : Colors.grey.withOpacity(0.5),
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
                if(isTasks) SizedBox(height: 7),
                topic == null || topic.trim() == ""
                    ? Container(
                        width: 0,
                        height: 0,
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: isTasks ? 7 : 0, top: isTasks ? 0 : 3),
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
                if (isTasks == true)
                  Text(
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
                    if (isTasks == true)
                      Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: taskColor,
                        ),
                      ),
                    if (room != null)
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
                        ? Row(
                            children: [
                              TextButton(
                                child: Text("EDIT"),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alertDialog;
                                    },
                                  );
                                },
                              ),
                              TextButton(
                                child: Text("DELETE"),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return deleteBox;
                                    },
                                  );
                                },
                              ),
                            ],
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
}
