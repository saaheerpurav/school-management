import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:school_management/screens/home_screen/components/drawerIcon.dart';
import 'package:school_management/drawer.dart';
import 'package:school_management/functions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String schoolName;
  String schoolCode;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference schools =
      FirebaseFirestore.instance.collection('schools');

  String name = "";
  String email = FirebaseAuth.instance.currentUser.email;
  String docId;
  String type;

  String message = "";
  double _inputHeight = 50;
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map> messages;

  checkWhereExists(String collection) async {
    bool exists = false;
    await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        var data = doc.data();
        if (data['email'] == email) {
          exists = true;
          setState(() {
            name = data['name'];
            schoolCode = data['school_code'];
            docId = doc.id;
          });
        } else {
          exists = false;
        }
      });
    });
    return exists;
  }

  void asyncMethod() async {
    if (await checkWhereExists('users')) {
      setState(() {
        type = "teacher";
      });
    } else if (await checkWhereExists('schools')) {
      setState(() {
        type = "admin";
      });
    } else {
      debugPrint("Error");
    }

    if (schoolCode != null) {
      schools
          .where('school_code', isEqualTo: schoolCode)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          var data = doc.data();

          setState(() {
            messages = data['messages'] == null ? [] : [...data['messages']];
          });
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          if (messages != null &&
              messages.isNotEmpty &&
              _scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 300),
            );
          }
        });
      });
    }
  }

  void _checkInputHeight() async {
    int count = _textEditingController.text.split('\n').length;

    if (count == 0 && _inputHeight == 50) {
      return;
    }
    if (count <= 5) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 100),
        );
      }

      var newHeight = count == 0.0 ? 50.0 : 28.0 + (count * 18.0);
      setState(() {
        _inputHeight = newHeight;
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_checkInputHeight);
    asyncMethod();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  sendMessage() {
    setState(() {
      messages.add({
        "content": message,
        "time": DateTime.now().millisecondsSinceEpoch,
      });
      message = "";
    });
    _textEditingController.clear();

    schools.doc(docId).update({
      'messages': messages,
    });
  }

  Widget emptyText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    bool isSendButtonDisabled = message.trim().isEmpty;

    return Scaffold(
      bottomSheet: type == "admin"
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: _inputHeight + 10,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: _inputHeight - 10,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            message = value;
                          });
                        },
                        keyboardType: TextInputType.multiline,
                        controller: _textEditingController,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                          ),
                          hintText: "Enter message",
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          fillColor: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 50 / 4 - 1,
                    bottom: 50 / 4 - 1,
                    width: 30,
                    height: 30,
                    child: TextButton(
                      onPressed: isSendButtonDisabled ? null : sendMessage,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          isSendButtonDisabled
                              ? Colors.grey
                              : Color(0XFF1C77FF),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: 0,
              height: 0,
            ),
      drawer: CustomDrawer(),
      body: Container(
        padding: EdgeInsets.only(top: 24),
        color: Color(0XFFD4E7FE),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Row(
                      children: [
                        drawerIcon(
                            context, EdgeInsets.symmetric(horizontal: 10)),
                        Text(
                          "Chat",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF263064),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: schoolCode == null
                            ? type == "teacher"
                                ? emptyText("You have not joined a school")
                                : Center(
                                    child: CircularProgressIndicator(),
                                  )
                            : messages == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : messages.isEmpty
                                    ? emptyText("No messages")
                                    : Container(
                                        padding: EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                          bottom: type == "admin"
                                              ? _inputHeight
                                              : 0,
                                        ),
                                        child: ListView(
                                          controller: _scrollController,
                                          children: messages
                                              .map(
                                                (e) => Column(
                                                  crossAxisAlignment: type ==
                                                          "teacher"
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              100),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0XFF1C77FF),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft: Radius
                                                              .circular(type ==
                                                                      "teacher"
                                                                  ? 5
                                                                  : 15),
                                                          bottomRight: Radius
                                                              .circular(type ==
                                                                      "admin"
                                                                  ? 5
                                                                  : 15),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        e['content'],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      dateToReadableTime(
                                                        DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                          e['time'],
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(height: 15),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
