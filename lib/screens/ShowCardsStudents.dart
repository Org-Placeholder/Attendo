import 'package:attendo/screens/MarkAttendanceStudents.dart';
import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
class ClassesforStudents extends StatefulWidget {
  @override
  _ClassesforStudentsState createState() => _ClassesforStudentsState();
}

class _ClassesforStudentsState extends State<ClassesforStudents> with SingleTickerProviderStateMixin {
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
        title: Text("Classes For Students"),
      ),
      body:  TabBarView(
        controller: controller,
        children: <Widget>[
          ShowCardsStudents(),
        ],
      ),
    );
  }
}
class ShowCardsStudents extends StatefulWidget {
  @override
  _ShowCardsStudentsState createState() => _ShowCardsStudentsState();
}

class _ShowCardsStudentsState extends State<ShowCardsStudents>{
  //your shitty database code goes here
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
               itemBuilder: (BuildContext context, int index) =>
          Container (
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
                    Row(
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
                            FlatButton(
                              child :
                              Text(ClassStudent[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                              //Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold,  )),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceStudents()));
                              },
                            ),
                              Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold), textAlign: TextAlign.end ,),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
        ),
      );
    }
}




