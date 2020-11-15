import 'package:attendo/screens/prof-student-common-drawer.dart';

import 'constants.dart';
import 'package:flutter/material.dart';

class MarkAttendanceStudents extends StatelessWidget {
  final String courseName;

  MarkAttendanceStudents({Key key, @required this.courseName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          centerTitle: true,
          toolbarHeight: 100,
          title: Text(courseName),
        ),
        drawer: account_drawer(
        Name: "Angad Kambli" +", " + "19114041" ,//Angad kambli ke jagah naam aur 1911.. ke jagah uid aayega
        Email: "kambli_a@yabadabadooooooooo.com",
        ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
      ),
    );
  }
}
