import 'constants.dart';
import 'package:flutter/material.dart';

class MarkAttendanceStudents extends StatelessWidget {
  // Declare a field that holds the Todo.
  final String courseName;

  // In the constructor, require a Todo.
  MarkAttendanceStudents({Key key, @required this.courseName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Text("Yet to be implemented. Page for " + courseName,)
    );
  }
}
