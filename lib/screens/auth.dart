import 'package:attendo/screens/professor-login.dart';
import 'package:attendo/screens/student-login.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      backgroundColor: PrimaryColor,

    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset("assets/images/welcome-screen-design.png", width: size.width,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo-white.png", width: size.width * 0.5,),
              SizedBox(height: 5,),
              Text("WELCOME TO ATTENDO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white), ),
              SizedBox(height: 50,),
              Container(
                width: size.width*0.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    color: Colors.white,
                    child: Text("Student Login", style: TextStyle(fontSize: 25, color: PrimaryColor),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentLoginScreen()));
                      print("reached");
                    },
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: size.width*0.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    color: Colors.white,
                    child: Text("Professor Login", style: TextStyle(fontSize: 25, color: PrimaryColor),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessorLoginScreen()));
                      print("reached");
                    },
                  ),
                ),
              ),
              SizedBox(height: 150,),
            ],
          )

        ],
      ),
    );


  }
}

