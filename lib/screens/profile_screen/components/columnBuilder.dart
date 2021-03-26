import 'package:flutter/material.dart';

Widget columnsBuilder(List list, [bool labels = false]) {
  List<String> informationLabels = [
    "Name",
    "Date Of Birth",
    "Age",
    "Blood Group",
    "Contact",
    "Email",
    "Adhaar Card Number"
  ];

  var listMap = list.asMap();
  var newListMap = {};

  listMap.forEach((key, value) {
    newListMap[key] = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labels
            ? Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(informationLabels[key]),
              )
            : Container(
                width: 0,
                height: 0,
              ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 5, bottom: labels ? 20 : 5, left: 20, right: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: TextEditingController()..text = value.toString(),
            onChanged: (text){
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  });

  var finalList = newListMap.values.toList();

  return ListView(
    children: finalList.map<Widget>((data) => data).toList(),
  );
}
