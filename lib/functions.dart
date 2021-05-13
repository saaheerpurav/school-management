import 'package:flutter/material.dart';

bool validateEmail(String value) {
  return RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(value);
}

showAlert(
    BuildContext context, String title, String text, Function onPressFunction,
    [String confirmText]) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          if (confirmText != null)
            TextButton(
              child: Text("CANCEL"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          TextButton(
            child: Text(confirmText ?? "OK"),
            onPressed: onPressFunction,
          ),
        ],
      );
    },
  );
}

String getMonthName(int monthInt) {
  String month;

  switch (monthInt) {
    case 1:
      month = "January";
      break;
    case 2:
      month = "February";
      break;
    case 3:
      month = "March";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "June";
      break;
    case 7:
      month = "July";
      break;
    case 8:
      month = "August";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "October";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "December";
      break;
  }

  return month;
}

String getDayName(int dayInt) {
  String day;

  switch (dayInt) {
    case 1:
      day = "Mon";
      break;
    case 2:
      day = "Tue";
      break;
    case 3:
      day = "Wed";
      break;
    case 4:
      day = "Thu";
      break;
    case 5:
      day = "Fri";
      break;
    case 6:
      day = "Sat";
      break;
    case 7:
      day = "Sun";
      break;
  }

  return day;
}

String getMonthInt(String monthName) {
  List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String num = (monthList.indexOf(monthName) + 1).toString();
  if (num.length == 1) num = "0$num";

  return num;
}

String getDeadlineMessage(DateTime date) {
  var difference = date.difference(DateTime.now()).inDays + 1;
  String deadlineMessage;

  if (difference == 1) {
    deadlineMessage = "1 Day left";
  } else {
    deadlineMessage = "$difference Days left";
  }

  return deadlineMessage;
}

String getCorrectDateFormat(Map data) {
  String day = data['deadline'].substring(0, data['deadline'].length - 2);
  if (day.length == 1) day = "0$day";

  return "${DateTime.now().year}-${getMonthInt(data['month'])}-$day";
}

bool isLeapYear(int year) {
  bool isLeap = false;

  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0)
        isLeap = true;
      else
        isLeap = false;
    } else
      isLeap = true;
  } else {
    isLeap = false;
  }
  return isLeap;
}

int getDaysInMonth() {
  var date = DateTime.now();

  if (getMonthName(date.month) == "February") {
    if (isLeapYear(date.year))
      return 29;
    else
      return 28;
  } else {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
}

String dateToReadableTime(var date){
  String timeType = "AM";
  int hour;
  String minute;

  if (date.hour >= 12) {
    hour = date.hour - 12;
    timeType = "PM";
  } else {
    hour = date.hour;
    timeType = "AM";
  }
  if (hour == 0) hour = 12;
  date.minute == 0 ? minute = "00" : minute = date.minute.toString();
  if(minute.length == 1) minute = "0$minute";

  return "$hour:$minute $timeType";
}