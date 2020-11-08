import 'package:attendo/networking/networkservicediscovery.dart';
import 'package:attendo/networking/socket.dart';
import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:attendo/screens/success-dialog.dart';
import 'package:attendo/screens/student-course-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:attendo/screens/failure-dialog.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/student-course-details.dart';
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
      drawer: account_drawer(
        Name: "Angad Kambli" +", " + "19114041" ,//Angad kambli ke jagah naam aur 1911.. ke jagah uid aayega
        Email: "kambli_a@yabadabadooooooooo.com",
        ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
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
    'Object Oriented Design and Des' ,'Data Structures and Laboratory' , 'Computer Architecture' , 'Signals and Sytems' , 'ThermoDynamics' , 'Economics'
    // ^ Yeh thik karna
  ];

  var ImageURL = [
    "https://picsum.photos/id/237/200/300",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300"
  ];
  var MoreIcon = Icon(
    Icons.more_vert,
    color: Colors.grey.shade900,
  );
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          //Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceStudents(courseName: CourseName[index],)));

                          String serviceName = "_"+ClassStudent[index]+"._tcp",enrollment_num = '19114001';
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
                            showAttendanceMarkedSuccess.ConfirmDialog(context, 'Marked!', ClassStudent[index]);
                          } else {
                            showAttendanceMarkedFailure.ConfirmDialog(context, 'Marked!', ClassStudent[index]);
                          }

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
                                backgroundImage: NetworkImage(ImageURL[index]),
                                ),
                              ),
                              SizedBox(width : 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Text(ClassStudent[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                  // Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold,  )),
                                  Text(ClassStudent[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                                  //Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold,  )),
                                  Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold), textAlign: TextAlign.end ,),
                                ],
                              ),
                            //Spacer(),

                            ],
                          ),
                      ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon:MoreIcon,
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentCourseDetails()));
                              },
                            )
                          ],
                        ),
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




