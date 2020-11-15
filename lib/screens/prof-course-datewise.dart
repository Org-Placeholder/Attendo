
import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DatewiseClassDeets extends StatefulWidget {
  @override
  _DatewiseClassDeetsState createState() => _DatewiseClassDeetsState();
}

class _DatewiseClassDeetsState extends State<DatewiseClassDeets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        toolbarHeight: 100,
        title: Text("Date"),
    ),
    body:  Container(
    child: ShowdataProfCourse(),
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
class ShowdataProfCourse extends StatefulWidget {
  @override
  _ShowdataProfCourseState createState() => _ShowdataProfCourseState();
}

class _ShowdataProfCourseState extends State<ShowdataProfCourse> {
  @override
  Widget build(BuildContext context) {

    int decimals = 2;
    int fac = pow(10, decimals);
    double d = 1.234567889;
    d = (d * fac).round() / fac;
    final int TotStudents = 100;
    var TotAttended = 20;
    double ratio_attended = (TotAttended/TotStudents * fac).round() / fac;
    var bar_color;
    if(ratio_attended > 0.5) {
      bar_color = Colors.green;
    }
    else {
      bar_color = Colors.red;
    }
    var percentage = (ratio_attended)*100;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height*0.5,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: size.height*0.3,
                  height: size.height*0.3,
                  child: new CircularProgressIndicator(
                    strokeWidth: 15,
                    value: ratio_attended,
                    valueColor: new AlwaysStoppedAnimation<Color>(bar_color),
                  ),
                ),
              ),
              Center(child:
              Text("${percentage}% attendance"),
              ),
            ],
          ),
        ),
        Container(
          height: 24,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Total Students", style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
        Container(
          height: 24,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("${TotStudents}" , style: TextStyle(fontSize: 18),),
              )
            ],
          ),
        ),

        Container(
          height: 24,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Total Class Attendance ", style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold, ),),
                )
            ],
          ),
        ),
        Container(
          height: 24,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("${TotAttended}" , style: TextStyle(fontSize: 18),),
              )
            ],
          ),
        ),
      ],
    );
  }
}


