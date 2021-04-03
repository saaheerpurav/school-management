import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ColumnBuilder extends StatefulWidget {
  Function callback;
  List list;
  String type;
  bool labels;

  //ColumnBuilder(this.callback, List list, [bool labels = false]);
  ColumnBuilder(this.callback, this.list, this.type, [this.labels = false]);

  @override
  _ColumnBuilderState createState() => _ColumnBuilderState();
}

class _ColumnBuilderState extends State<ColumnBuilder> {
  List<String> informationLabels = [
    "Name",
    "Date Of Birth",
    "Age",
    "Blood Group",
    "Contact",
    "Email",
    "Adhaar Card Number"
  ];

  var newListMap = {};

  @override
  void initState(){
    widget.list.asMap().forEach((key, value) {
      newListMap[key] = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.labels
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
            margin: EdgeInsets.only(
                top: 5, bottom: widget.labels ? 20 : 5, left: 20, right: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: TextEditingController()..text = value.toString(),
              onTap: () {
                widget.callback(value, widget.type, widget.list.indexOf(value));
              },
              onChanged: (text) {
                widget.callback(text, widget.type, widget.list.indexOf(text));
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
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: newListMap.values.toList().map<Widget>((data) => data).toList(),
    );
  }
}
