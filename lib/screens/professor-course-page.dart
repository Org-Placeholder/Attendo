
import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:attendo/screens/professor-take-attendance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/prof-course-datewise.dart';

class ProfCourseScreen extends StatefulWidget {
  String course_code,uid;
  ProfCourseScreen(String code, String temp)
  {
    course_code = code;
    uid = temp;
  }

  @override
  _ProfCourseScreenState createState() => _ProfCourseScreenState(course_code,uid);
}

class _ProfCourseScreenState extends State<ProfCourseScreen> {
  int tab = 0;
  String course_code;
  String uid;
  _ProfCourseScreenState(String code,temp)
  {
    course_code = code;
    uid = temp;
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
      tab_child = prof_lectures(course_code);
    }
    else
    {
      color1 = SecondaryColor;
      color2 = PrimaryColor;
      tab_child = students_attendance();
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
      Name: "Angad Kambli" +", " + "19114041" ,//Angad kambli ke jagah naam aur 1911.. ke jagah uid aayega
      Email: "kambli_a@yabadabadooooooooo.com",
      ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",

      ),
      floatingActionButton: FloatingActionButton.extended(
      elevation: 2.0,
      onPressed: () async {
      //Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceStudents(courseName: CourseName[index],)));
        Navigator.push(context, MaterialPageRoute(builder : (context) => MarkAttendanceProfessor(courseCode: course_code,)));

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

class prof_lectures extends StatelessWidget {
  String course_code;
  prof_lectures(String temp) {
    course_code = temp;
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
  var num_attended = [
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    90,
    90,
  ];
  var Enrollment = [
    '19114001','19114002','19114003','19114004','19114005','19114006','19114007','19114008','19114009','19114010','19114011','19114012','19114013','19114014','19114015','19114016','19114017','19114018','19114019','19114020','19114021','19114022','19114023','19114024','19114025','19114026','19114027','19114028','19114029','19114030','19114031','19114032','19114033','19114034','19114035','19114036','19114037','19114038','19114039','19114040','19114041','19114042','19114043','19114044','19114045','19114046','19114047','19114048','19114049','19114050','19114051','19114052','19114053','19114054','19114055','19114056','19114057','19114058','19114059','19114060','19114061','19114062','19114063','19114064','19114065','19114066','19114067','19114068','19114069','19114070','19114071','19114072','19114073','19114074','19114075','19114076','19114077','19114078','19114079','19114080','19114081','19114082','19114083','19114084','19114085','19114086','19114087','19114088','19114089','19114090','19114091','19114092','19114093','19114094','19114095','19114096','19114097','19114098','19114099'
  ];
  var Dates = [
    '1-1-2020 ',
    '2-2-2020 ',
    '3-3-2020 ',
    '4-4-2020 ',
    '5-5-2020 ',
    '6-6-2020 ',
    '7-7-2020 ',
    '8-8-2020 ',
    '9-9-2020 ',
    '10-10-2020 ',
    '11-11-2020 ',
  ];
  @override
  Widget build(BuildContext context) {
    var percentcolor;
    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height*0.7,
          child: ListView.builder(
            itemCount: Dates.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                onTap: () {
                  Navigator.push((context), MaterialPageRoute(builder: (context) => DatewiseClassDeets(num_attended[index], Enrollment.length, Dates[index])));
                 },
                child: Container(
                  padding: EdgeInsets.only(left: 15.0 , right: 15.0),
                  height: 45,
                  child : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children : <Widget>[
                      Container(
                        child: Text(Dates[index] , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ),
                    ]
                  ),
                ),
              );
            }
          )
      ),
    );
  }
}

class students_attendance extends StatelessWidget {
  String course_code;
  students_attendance(String temp) {
    course_code = temp;
  }
  var ImageURL = [
    /*"https://internet.channeli.in/media/kernel/display_pictures/2e447df4-5763-44fd-9c5a-3ec45217c76c.jpg",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300"*/
  ];
  var percentage = [ 10 , 20 , 30 ,50 ,30 ,20 ,15 , 20 ,70 ,90  ];
  var Enrollment = [
    '19114001','19114002','19114003','19114004','19114005','19114006','19114007','19114008','19114009','19114010','19114011','19114012','19114013','19114014','19114015','19114016','19114017','19114018','19114019','19114020','19114021','19114022','19114023','19114024','19114025','19114026','19114027','19114028','19114029','19114030','19114031','19114032','19114033','19114034','19114035','19114036','19114037','19114038','19114039','19114040','19114041','19114042','19114043','19114044','19114045','19114046','19114047','19114048','19114049','19114050','19114051','19114052','19114053','19114054','19114055','19114056','19114057','19114058','19114059','19114060','19114061','19114062','19114063','19114064','19114065','19114066','19114067','19114068','19114069','19114070','19114071','19114072','19114073','19114074','19114075','19114076','19114077','19114078','19114079','19114080','19114081','19114082','19114083','19114084','19114085','19114086','19114087','19114088','19114089','19114090','19114091','19114092','19114093','19114094','19114095','19114096','19114097','19114098','19114099'
  ];
  @override
  Widget build(BuildContext context) {
    var percentcolor;
    return Container(
      height: MediaQuery.of(context).size.height*0.7,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) =>
          SingleChildScrollView(
            child: ListTile(
              trailing: Text("${percentage[index]}%" ,style: TextStyle(color: (percentage[index] < 50) ? Colors.red:Colors.green,fontSize: 18)),
              title : Text("${Enrollment[index]}" , style: TextStyle(color: Colors.black , fontSize: 18 , fontWeight: FontWeight.bold),),
           )
        ),
      )
      );
  }
}
