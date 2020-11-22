
import 'package:attendo/controller/controller.dart';
import 'package:attendo/models/database.dart';
import 'package:attendo/models/user.dart';
import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:attendo/screens/professor-take-attendance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/prof-course-datewise.dart';

class ProfCourseScreen extends StatefulWidget {
  String course_code,uid,email;
  userinfo user;
  ProfCourseScreen(String code, String temp,userinfo info,String email)
  {
    course_code = code;
    uid = temp;
    user = info;
    this.email = email;
  }

  @override
  _ProfCourseScreenState createState() => _ProfCourseScreenState(course_code,uid,user,email);
}

class _ProfCourseScreenState extends State<ProfCourseScreen> {
  int tab = 0;
  String course_code;
  String uid;
  String email;
  userinfo user;
  _ProfCourseScreenState(String code,String temp,userinfo info,String email)
  {
    course_code = code;
    uid = temp;
    user = info;
    this.email = email;
  }
  @override
  Widget build(BuildContext context) {
    var color1;
    var color2;
    var tab_child;
    if(tab == 0)
    {
      color1 = PrimaryColor;
      color2 = SecondaryColor;
      tab_child = prof_lectures(course_code,email,user);

    }
    else
    {
      color1 = SecondaryColor;
      color2 = PrimaryColor;
      tab_child = students_attendance(course_code);
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
      backgroundColor: PrimaryColor,
      centerTitle: true,
      toolbarHeight: 100,
      title: Text(course_code),
      ),
      drawer: account_drawer(
      Name: user.getname()+", " + user.getenrollno(),//Angad kambli ke jagah naam aur 1911.. ke jagah uid aayega
      Email: email,
      ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",

      ),
      floatingActionButton: FloatingActionButton.extended(
      elevation: 2.0,
      onPressed: () async {
      //Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceStudents(courseName: CourseName[index],)));
        Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceProfessor(courseCode: course_code,email: email,user:user)));
      },
        backgroundColor: PrimaryColor,
        label: Text("Take Attendance"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: color1,
                  child: FlatButton(
                    child: Text("Lectures", style: TextStyle(color: Colors.white),),
                    onPressed: ()
                    {
                      if(tab != 0)
                      {
                        setState(()
                        {
                          tab = 0;
                        });
                      }
                    },
                  ),
                  width: size.width*0.5,
                ),
                Container(
                  color: color2,
                  child: FlatButton(
                    child: Text("Students", style: TextStyle(color: Colors.white)),
                    onPressed: ()
                    {
                      if(tab != 1)
                      {
                        setState(()
                        {
                          tab = 1;
                        });
                      }
                    },
                  ),
                  width: size.width*0.5,
                )
              ],
            ),
            SizedBox(height: 10,),
            tab_child,
          ],
        ),
      ),
    );
  }
}

class prof_lectures extends StatefulWidget {
  String course_code;
  String email;
  userinfo user;
  prof_lectures(String temp,String email,userinfo info) {
    course_code = temp;
    user = info;
    this.email = email;
  }

  @override
  _prof_lecturesState createState() => _prof_lecturesState(course_code,email,user);
}

class _prof_lecturesState extends State<prof_lectures> {
  var num_attended;
  var Enrollment;
  List<String> Dates;
  String course_code;
  String email;
  userinfo user;
  Future<void> result;
  _prof_lecturesState(String temp,String email,userinfo info){
    course_code = temp;
    Enrollment = [];
    Dates = [];
    num_attended = [];
    result = initialize_lists();
    this.email = email;
    user = info;
  }
  @override
  var ImageURL = [
    /*"https://internet.channeli.in/media/kernel/display_pictures/2e447df4-5763-44fd-9c5a-3ec45217c76c.jpg",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300"*/
  ];

  //Enrollment = await service.getenroll(widget.course_code);
  Future<void> initialize_lists() async{
    DatabaseService service = new DatabaseService();
    Enrollment = await service.getenrollno(course_code);
    ControllerService service_ = new ControllerService();
    Map<String,int> mp = await service_.getAttendanceByDate(course_code);
    for(String k in mp.keys){
      try {
        Dates.add(k);
      }catch(e){
        print(e);
      }
      num_attended.add(mp[k]);
    }
    return;
  }
  @override
  Widget build(BuildContext context) {
    var percentcolor;
    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height*0.7,
          child:  FutureBuilder<void>(
            future: result,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if(Enrollment.length > 0){
                return ListView.builder(
                    itemCount: Dates.length,
                    itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    onTap: () {
                      Navigator.push((context), MaterialPageRoute(builder: (context) => DatewiseClassDeets(num_attended[index], Enrollment.length, Dates[index],email,user)));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15.0 , right: 15.0),
                      height: 45,
                      child : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children : <Widget>[
                            Container(
                              child: Text("Lecture ${index+1}: "+Dates[index].split('.')[0] , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            ),
                          ]
                      ),
                    ),
                  );
                });
              }
              else if(snapshot.hasError){
                return Text('Error,please try again later');
              }
              else {
                  return SizedBox(
                    child: CircularProgressIndicator(),
                    width: MediaQuery.of(context).size.width*0.1,
                    height: MediaQuery.of(context).size.width*0.1,
                  );
              }
            }
          )
      ),
    );
  }
}

class students_attendance extends StatelessWidget {
  String course_code;
  List<double> percentage = [];
  List<String> enrollment = [];
  Future<void> result;
  students_attendance(String temp) {
    course_code = temp;
    result = initialize_lists();
  }
  Future<void> initialize_lists() async{
    ControllerService service = new ControllerService();
    Map mp = await service.getClassAttendedByStudents(course_code);
    print(mp);
    for(String k in  mp.keys){
      if(k!="total") {
        enrollment.add(k);
        double d = 100.0;
        if(mp["total"]==0)
            d = 0;
        else
          d = (d*mp[k])/mp["total"];
        percentage.add(d);
      }
    }
  }
  var ImageURL = [
    /*"https://internet.channeli.in/media/kernel/display_pictures/2e447df4-5763-44fd-9c5a-3ec45217c76c.jpg",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300"*/
  ];
  @override
  Widget build(BuildContext context) {
    var percentcolor;
    return Container(
      height: MediaQuery.of(context).size.height*0.7,
      child:FutureBuilder<void>(
        future: result,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if(percentage.length>0){
            return ListView.builder(
              itemCount: percentage.length,
              itemBuilder: (BuildContext context, int index) =>
                SingleChildScrollView(
                  child: ListTile(
                  trailing: Text("${percentage[index]}%" ,style: TextStyle(color: (percentage[index] < 50) ? Colors.red:Colors.green,fontSize: 18)),
                  title : Text("${enrollment[index]}" , style: TextStyle(color: Colors.black , fontSize: 18 , fontWeight: FontWeight.bold),),
                )
              ),
            );
          }
          else if(snapshot.hasError){
            return Text('Error,please try again later');
          }
          else{
            return SizedBox(
              child: CircularProgressIndicator(),
              width: MediaQuery.of(context).size.width*0.1,
              height: MediaQuery.of(context).size.width*0.1,
            );
          }
        }
      )
    );
  }
}
