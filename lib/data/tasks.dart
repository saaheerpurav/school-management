import 'package:flutter/material.dart';
import 'package:school_management/screens/calendar_screen/components/taskAddForm.dart';

List<Map> tasks(List colors, [BuildContext context, Function callback]){
  List<Map> allTasks = [
    {
      'task': "Create Time Table",
      'description': "Create Class Time Table for Class I",
      'deadline': '29th',
      'month': 'March',
      'deadlineMessage': '1 Day left',
      'status': 'Complete',
      'isEdit': false,
      'id': 1,
      'color': colors[0],
      'formWidget': TaskAddForm(callback),
      'context': context,
    },
    {
      'task': "Create Quiz",
      'description': "Create Geography Quiz for Class X",
      'deadline': '8th',
      'month': 'April',
      'deadlineMessage': '10 Days left',
      'status': 'Incomplete',
      'isEdit': false,
      'id': 3,
      'color': colors[1],
      'formWidget': TaskAddForm(callback),
      'context': context,
    },
    {
      'task': "Decide Class X Farewell Food Menu",
      'deadline': '10th',
      'month': 'May',
      'deadlineMessage': '30 Days left',
      'status': 'Incomplete',
      'isEdit': false,
      'id': 5,
      'color':  colors[2],
      'formWidget': TaskAddForm(callback),
      'context': context,
    },
    {
      'task': "Create Presentaion",
      'description': "Presentaion for Class X on Natural Regions",
      'deadline': '4th',
      'month': 'April',
      'deadlineMessage': '11 Days left',
      'status': 'Complete',
      'isEdit': false,
      'id': 4,
      'color': colors[3],
      'formWidget': TaskAddForm(callback),
      'context': context,
    },
    {
      'task': "Create Video",
      'description': "Class X Memories Video for Annual Concert",
      'deadline': '3rd',
      'month': 'April',
      'deadlineMessage': '5 Days left',
      'status': 'Incomplete',
      'isEdit': false,
      'id': 2,
      'color':  colors[4],
      'formWidget': TaskAddForm(callback),
      'context': context,
    },
  ];

  return allTasks;
}