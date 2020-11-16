import 'package:attendo/models/database.dart';
import 'package:attendo/models/user.dart';
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
  String uid;
  userinfo user;
  String email;
  CoursesforStudents(String temp,userinfo info,String email) {
    uid = temp;
    user = info;
    this.email = email;
  }
  @override
  _CoursesforStudentsState createState() => _CoursesforStudentsState(uid,user,email);
}

class _CoursesforStudentsState extends State<CoursesforStudents> with SingleTickerProviderStateMixin {
  TabController controller;
  String uid;
  String email;
  userinfo user;
  _CoursesforStudentsState(String temp,userinfo info,String email) {
    uid = temp;
    user = info;
    this.email = email;
  }
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
          BuildStudentCourseCards(uid,user,email),
        ],
      ),
      drawer: account_drawer(
        Name: user.getname() +", " + user.getenrollno() ,
        Email: email,
        ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
      ),
    );
  }
}
class BuildStudentCourseCards extends StatefulWidget {
  String uid;
  userinfo user;
  String email;
  BuildStudentCourseCards(String temp,userinfo info,String email) {
    uid = temp;
    user = info;
    this.email = email;
  }
  @override
  _BuildStudentCourseCardsState createState() => _BuildStudentCourseCardsState(uid,user,email);
}

class _BuildStudentCourseCardsState extends State<BuildStudentCourseCards>{
  String uid;
  userinfo user;
  String email;
  _BuildStudentCourseCardsState(String temp,userinfo info,String email) {
    uid = temp;
    user = info;
    this.email = email;
  }
  DatabaseService Service =new DatabaseService();
  var ClassStudent = [];
  var CourseName = [];
  var ImageURL = [];
  var ImageRepo = [
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img1.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img2.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img3.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img4.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img5.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img6.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img7.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img8.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img9.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img10.png",
  ];
  var MoreIcon = Icon(
    Icons.more_vert,
    color: Colors.grey.shade900,
  );
 void getcourses() async{
   var classStudent_temp=[],courseName_temp=[],imageurl_temp=[];
   var result=await Service.getStudentCourses(user.getenrollno());
   print('aya');
   for(int i=0;i<result.length;i++)
      {
          print(i);
          classStudent_temp.add(result[i].get("Course_Code"));
          courseName_temp.add(result[i].get("Course_Name"));
          String courseCodeTemp = result[i].get("Course_Code");
          int x = int.parse(courseCodeTemp[courseCodeTemp.length-1] + courseCodeTemp[courseCodeTemp.length-2]);
          x = x % ImageRepo.length;
          imageurl_temp.add(ImageRepo[x]);
      }
  setState(() {
    ClassStudent=classStudent_temp;
    CourseName=courseName_temp;
    ImageURL=imageurl_temp;
  });
 }
  @override
  Widget build(BuildContext context) {
    if(ClassStudent.length==0)
        getcourses();
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
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentCourseDetails(ClassStudent[index],user,email)));
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




