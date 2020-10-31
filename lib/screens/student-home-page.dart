import 'package:attendo/screens/student-course-page.dart';
import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
class CoursesforStudents extends StatefulWidget {
  @override
  _CoursesforStudentsState createState() => _CoursesforStudentsState();
}

class _CoursesforStudentsState extends State<CoursesforStudents> with SingleTickerProviderStateMixin {
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
        title: Text("Your courses :)"),
      ),
      body:  TabBarView(
        controller: controller,
        children: <Widget>[
          BuildStudentCourseCards(),
        ],
      ),
    );
  }
}
class BuildStudentCourseCards extends StatefulWidget {
  @override
  _BuildStudentCourseCardsState createState() => _BuildStudentCourseCardsState();
}

class _BuildStudentCourseCardsState extends State<BuildStudentCourseCards>{

  var ClassStudent = [
    'CSN-261', 'CSN-291' , 'CSN-221' , 'ECN-203' , 'MIN-106' , 'HSN-002'
  ];
  var CourseName = [
    'Object Oriented Design and Analysis' ,'Data Structures and Laboratory' , 'Computer Architecture' , 'Signals and Sytems' , 'ThermoDynamics' , 'Economics'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:PrimaryColor,
        body :
        ListView.builder(
          itemCount: ClassStudent.length,
          itemBuilder: (BuildContext context, int index) =>
          SingleChildScrollView(
            child: Container (
              width : MediaQuery.of(context).size.width,
              padding : EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5.0),
                child: Card(
                  elevation : 5.0,
                  shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)
                  ),
                  child : Container (
                    width : MediaQuery.of(context).size.width,
                    padding:  EdgeInsets.symmetric(horizontal: 10.0,vertical : 10.0),
                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceStudents(courseName: CourseName[index],)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width : 60,
                              height: 60,
                              // color : LightColor,
                              child : CircleAvatar (
                                backgroundColor: PrimaryColor,
                                foregroundColor: LightColor,
                                backgroundImage: NetworkImage("https://picsum.photos/id/237/200/300"),
                                ),
                              ),
                              SizedBox(width : 10),
                              Column (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Text(ClassStudent[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                  // Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold,  )),
                                  Text(ClassStudent[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                                  //Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold,  )),

                                  Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold), textAlign: TextAlign.end ,),
                                ],
                              )
                            ],
                          ),
                      )
                      ],
                    ),
                  ),
                ),
              ),
          ),
        ),
      );
    }
}




