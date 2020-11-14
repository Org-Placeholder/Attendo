import 'package:attendo/networking/networkservicediscovery.dart';
import 'package:attendo/networking/socket.dart';
import 'package:attendo/screens/failure-dialog.dart';
import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:attendo/screens/success-dialog.dart';
import 'package:attendo/screens/student-course-page.dart';
import 'package:flutter/cupertino.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class StudentCourseDetails extends StatefulWidget {
  String course_name;
  StudentCourseDetails(String courseName)
  {
    course_name = courseName;
  }
  @override
  _StudentCourseDetailsState createState() => _StudentCourseDetailsState(course_name);
}

class _StudentCourseDetailsState extends State<StudentCourseDetails>{
  String course_name;
  _StudentCourseDetailsState(String courseName)
  {
    course_name = courseName;
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          centerTitle: true,
          toolbarHeight: 100,
          title: Text(course_name),
        ),
          body:  Container(
            child: ShowCourseDetails(course_name),
          ),
        drawer: account_drawer(
          Name: "Angad Kambli" + ", " + "19114041",
          //Angad kambli ke jagah naam aur 1911.. ke jagah uid aayega
          Email: "kambli_a@yabadabadooooooooo.com",
          ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 2.0,
          onPressed: () async {
            //Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceStudents(courseName: CourseName[index],)));
            
            String serviceName = "_"+course_name+"._tcp";
            String enrollment_num = '19114001';
            ServiceDiscovery nsd = new ServiceDiscovery();

            var nsdResult = await nsd.discoverServices(serviceName);
            var serverMessage = "OK";
            if(nsdResult == null){
              serverMessage = "Error";
            }
            if(serverMessage == "OK") {
              print(nsdResult);
              String host = nsdResult["service.ip"];
              int port = nsdResult["service.port"];
              print("Port: "+port.toString());
              serverMessage = await connect_and_send(host,port,enrollment_num);
            }

            if(serverMessage == "OK") {
              showAttendanceMarkedSuccess.ConfirmDialog(context, 'Marked!', course_name);
            } else {
              showAttendanceMarkedFailure.ConfirmDialog(context, 'Marked!', course_name);
            }
          },
          backgroundColor: PrimaryColor,
          label: Text("Mark Attendance"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
}

class ShowCourseDetails extends StatefulWidget {

  String course_name;
  ShowCourseDetails(String courseName)
  {
    course_name = courseName;
  }

  @override
  _ShowCourseDetailsState createState() => _ShowCourseDetailsState(course_name);
}

class _ShowCourseDetailsState extends State<ShowCourseDetails> {

  String course_name;
  _ShowCourseDetailsState(String courseName)
  {
    course_name = courseName;
  }

  @override
  Widget build(BuildContext context) {


    //database functions go here


    int decimals = 2;
    int fac = pow(10, decimals);
    double d = 1.234567889;
    d = (d * fac).round() / fac;
    var TotTaken = 24;
    var TotAttended = 20;
    double ratio_attended = (TotAttended/TotTaken * fac).round() / fac;
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
                    Text("${percentage}% classes attended"),
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
                    child: Text("Total Classes Held", style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
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
                    child: Text("${TotTaken}" , style: TextStyle(fontSize: 18),),
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
                    child: Text("Total Classes Attended", style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
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

