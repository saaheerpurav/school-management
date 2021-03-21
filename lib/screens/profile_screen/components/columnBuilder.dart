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

  /*return Column(
    children: list
        .map(
          (item) => Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              item.toString(),
            ),
          ),
        )
        .toList(),
  );*/

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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value.toString(),
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
