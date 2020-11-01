import 'package:attendo/screens/DialogAddCourse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/professor-course-page.dart';
class ShowCoursesProfessor extends StatefulWidget {
  @override
  _ShowCoursesProfessorState createState() => _ShowCoursesProfessorState();
}

class _ShowCoursesProfessorState extends State<ShowCoursesProfessor> with SingleTickerProviderStateMixin {
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
        title: Text("Your Courses"),
      ),
      drawer: new Drawer(
        child: Center(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                  color: PrimaryColor,
                ),
                accountName: Text("Sandeep Kumar", textAlign: TextAlign.center,),
                accountEmail: Text("sandeep.garg@cs.iitr.ac.in", textAlign: TextAlign.center,),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage("https://internet.channeli.in/media/kernel/display_pictures/2e447df4-5763-44fd-9c5a-3ec45217c76c.jpg"),
                ),
              )
            ],
          )
        ),
      ),

      body:  TabBarView(
        controller: controller,
        children: <Widget>[
          ShowCardsProfessor(),
        ],
      ),
    );
  }
}



class ShowCardsProfessor extends StatefulWidget {
  @override
  _ShowCardsProfessor createState() => _ShowCardsProfessor();
}

class _ShowCardsProfessor extends State<ShowCardsProfessor> {
  @override
  Widget build(BuildContext context) {
    var ProfName  = [
      'Sandeep Kumar' , 'Balasubramanian Raman' , 'Sudeep Roy' , 'Subudhi Sudhakar' , 'Sateesh Kumar' , 'Falguni Pathnaik'
    ];
    var CourseName = [
      'Object Oriented Design and Analysis' ,'Data Structures and Laboratory' , 'Computer Architecture' , 'Signals and Systems' , 'ThermoDynamics' , 'Economics'
    ];
    var ImageURL = [
      "https://internet.channeli.in/media/kernel/display_pictures/2e447df4-5763-44fd-9c5a-3ec45217c76c.jpg",
      "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
      "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
      "https://picsum.photos/id/237/200/300",
      "https://picsum.photos/id/237/200/300",
      "https://picsum.photos/id/237/200/300"
    ];
    var ClassProfessor = [
      'CSN-261', 'CSN-291' , 'CSN-221' , 'ECN-203' , 'MIN-106' , 'HSN-002'
    ];
    bool TappedYes = false;
    TextField CourseCodeField;
    TextField CourseNameField;
    return Scaffold(
      backgroundColor:PrimaryColor,
      body :
      ListView.builder(
        itemCount: ProfName.length,
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
                            Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceProfessor(courseCode: ClassProfessor[index],)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width : 60,
                                height: 70,
                                // color : LightColor,
                                child : CircleAvatar (
                                  backgroundColor: PrimaryColor,
                                  foregroundColor: LightColor,
                                  backgroundImage: NetworkImage(ImageURL[index]),
                                ),
                              ),
                              SizedBox(width : 10),
                              Column (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Text(ClassStudent[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                  // Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold,  )),
                                  Text(ClassProfessor[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final action =DialogProfessor.yesAbortDialogue(context, 'Add Course', CourseCodeField, CourseNameField);
        },
        backgroundColor: PrimaryColor,
          child: Icon(Icons.add,),
      ),
    );
  }
}










