import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:attendo/screens/success-dialog.dart';
import 'package:attendo/screens/student-course-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
class StudentCourseDetails extends StatefulWidget {
  @override
  _StudentCourseDetailsState createState() => _StudentCourseDetailsState();
}

class _StudentCourseDetailsState extends State<StudentCourseDetails> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState(){
  super.initState();
  controller = new TabController(length: 1, vsync: this , initialIndex: 0);
  }
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          centerTitle: true,
          toolbarHeight: 100,
          title: Text("CourseName"),
        ),
          body:  TabBarView(
            controller: controller,
            children: <Widget>[
              // BuildStudentCourseCards(),
              ShowCourseDetails(),
            ],
          ),
        drawer: account_drawer(
          Name: "Angad Kambli" + ", " + "19114041",
          //Angad kambli ke jagah naam aur 1911.. ke jagah uid aayega
          Email: "kambli_a@yabadabadooooooooo.com",
          ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
        ),
      );
    }
}
class ShowCourseDetails extends StatefulWidget {
  @override
  _ShowCourseDetailsState createState() => _ShowCourseDetailsState();
}

class _ShowCourseDetailsState extends State<ShowCourseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row (
          mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
            child :SfRadialGauge()
            )
        ],
        ),
    );
  }
}

