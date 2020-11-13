import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

class ProfCourseScreen extends StatefulWidget {
  @override
  _ProfCourseScreenState createState() => _ProfCourseScreenState();
}

class _ProfCourseScreenState extends State<ProfCourseScreen> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    var color1;
    var color2;
    var tab_child;
    if(tab == 0)
    {
      color1 = PrimaryColor;
      color2 = SecondaryColor;
      tab_child = prof_lectures();
    }
    else
    {
      color1 = SecondaryColor;
      color2 = PrimaryColor;
      tab_child = students_attendance();
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(
      backgroundColor: PrimaryColor,
      centerTitle: true,
      toolbarHeight: 100,
      title: Text("CSN-420"),
      ),
      drawer: account_drawer(
      Name: "Angad Kambli" +", " + "19114041" ,//Angad kambli ke jagah naam aur 1911.. ke jagah uid aayega
      Email: "kambli_a@yabadabadooooooooo.com",
      ImageURL: "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
      ),
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
  @override
  Widget build(BuildContext context) {

    //database functions calls go here
    //this will show list of lectures along with date, number of students attended
    //devanshu your work is here
    return Container(
      child: Text("Lecture deets come here :)"),
    );
  }
}

class students_attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //database function calls go here
    //this will show list of students enrolled in the course along with their attendance percentage
    //devanshu your work is here too :0
    return Container(
      child: Text("Per student details come here :)"),
    );
  }
}
