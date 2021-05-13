import 'package:flutter/material.dart';

class ColumnBuilder extends StatefulWidget {
  final List list;
  final String type;
  final bool labels;
  final Function callback;
  final Function addField;

  ColumnBuilder(this.callback, this.addField, this.list, this.type,
      [this.labels = false]);

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
    "Aadhaar Number"
  ];

  var newListMap = {};

  createWidget(key, value) {
    TextInputType inputType = TextInputType.text;
    if(widget.labels){
      if(informationLabels[key] == "Contact") inputType = TextInputType.phone;
      else if(informationLabels[key] == "Age" || informationLabels[key] == "Aadhaar Number") inputType = TextInputType.number;
    }

    return Column(
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
              widget.callback(value, widget.type, key);
            },
            onChanged: (text) {
              widget.callback(text, widget.type, key);
            },
            keyboardType: inputType,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Enter Text",
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    widget.list.asMap().forEach((key, value) {
      newListMap[key] = createWidget(key, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = newListMap.values.toList().map<Widget>((data) => data).toList();
    var type = widget.type;

    return ListView(
      children: type == 'information'
          ? data
          : data +
              [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextButton(
                    onPressed: () {
                      widget.addField(type);
                      setState(() {
                        newListMap[newListMap.length] = createWidget(newListMap.length, "");
                      });
                    },
                    child: Text(
                      "New ${type.substring(0, 1).toUpperCase() + type.substring(1, type.length - 1)}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                  ),
                ),
              ],
    );
  }
}
