import 'package:attendo/controller/controller.dart';
import 'package:attendo/models/user.dart';
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
  userinfo user;
  String email;
  StudentCourseDetails(String courseName,userinfo info,String email)
  {
    user = info;
    course_name = courseName;
    this.email = email;
  }
  @override
  _StudentCourseDetailsState createState() => _StudentCourseDetailsState(course_name,user,email);
}

class _StudentCourseDetailsState extends State<StudentCourseDetails>{
  String course_name;
  userinfo user;
  String email;
  _StudentCourseDetailsState(String courseName,userinfo info,String email)
  {
    user = info;
    course_name = courseName;
    this.email = email;
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
            child: ShowCourseDetails(course_name,user),
          ),
        drawer: account_drawer(
          Name: user.getname() + ", " + user.getenrollno(),
          Email: email,
          ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 2.0,
          onPressed: () async {
            //Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceStudents(courseName: CourseName[index],)));
            
            String serviceName = "_"+course_name+"._tcp";
            String enrollment_num = user.getenrollno();
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
  userinfo user;
  ShowCourseDetails(String courseName,userinfo info)
  {
    user = info;
    course_name = courseName;
  }

  @override
  _ShowCourseDetailsState createState() => _ShowCourseDetailsState(course_name,user);
}

class _ShowCourseDetailsState extends State<ShowCourseDetails> {
  // declaring a controller service object to fetch student course details
  ControllerService Service = new ControllerService();
  int TotTaken=-1,TotAttended=-1;
  String course_name;
  userinfo user;
  _ShowCourseDetailsState(String courseName,userinfo info)
  {
    course_name = courseName;
    user = info;
  }
  void getDetails(String courseCode,String enrollno) async {
    var details=[];
    details=await Service.getClassesAttendedStudent(courseCode,enrollno);
    setState(() {
      TotAttended=details[0];
      TotTaken=details[1];
    });
  }
  @override
  Widget build(BuildContext context) {


    //database functions go here
    // put courseCode in place of MIN-106 and enrollno in place of 19114017
    if(TotTaken==-1) {
      getDetails(course_name, user.getenrollno());
    }
    int decimals = 2;
    int fac = pow(10, decimals);
    double d = 1.234567889;
    d = (d * fac).round() / fac;
    double ratio_attended;
    if(TotTaken==0)
       ratio_attended=0;
    else
      ratio_attended = (TotAttended/TotTaken * fac).round() / fac;
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

