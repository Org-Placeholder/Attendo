import 'package:attendo/models/auth_service.dart';
import 'package:attendo/models/database.dart';
import 'package:attendo/models/user.dart';
import 'package:attendo/screens/professor-home-page.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/registration.dart';

class ProfessorLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      backgroundColor: PrimaryColor,

    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth= AuthService();
  @override
  String error_msg = "";
  Widget build(BuildContext context) {
    final email_controller = TextEditingController();
    final password_controller = TextEditingController();

    Size size = MediaQuery.of(context).size;
    void submit() async
    {
      print("username = " + email_controller.text + " password = " + password_controller.text);
      if(email_controller.text == "" ||  password_controller.text == "")
      {
        setState(() {
          error_msg = "Please fill all the fields !";
        });
      }
     else{ // keeping the student and professor login same for now.
       dynamic result=await _auth.signInWithEmailAndPassword(email_controller.text, password_controller.text);
       if(result==null)
          {
            setState(() {
              error_msg = " Wrong Credentials, couldn't sign you in .";
            });
          }
       else{
         DatabaseService service =new DatabaseService();
         userinfo info = await service.getUserFromUid(result.uid);
         if(info.gettype()== 1){
           print("Login Sucessful");
           Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoursesProfessor()));
         }
         else{
           setState(() {
             error_msg="Please login with professor credentials.";
           });
         }
       }
     }
    }
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
          SingleChildScrollView(
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo-white.png", width: size.width * 0.5,),
                  SizedBox(height: 5,),
                  Text("Hello Professor!\nWe might need your credentials!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white), textAlign: TextAlign.center, ),
                  SizedBox(height: 25,),

                  Container(
                    width: size.width * 0.8,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                      controller: email_controller,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.email, size: 50, color: Colors.white),
                          labelText: "Email",
                          labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white60)
                      ),
                      autofillHints: [AutofillHints.email],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: size.width * 0.8,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0
                      ),
                      controller: password_controller,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.work, size: 50, color: Colors.white),
                          labelText: "Password",
                          labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white60)
                      ),
                      autofillHints: [AutofillHints.email],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(error_msg, style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600),),
                  FlatButton(
                    color: Colors.transparent,
                    child: Text("Don't have an account?", style: TextStyle(color: Colors.white60, fontSize: 17)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                    },
                  ),

                  SizedBox(height: 5,),
                  SubmitButton("Submit", submit),
                  FlatButton(
                    color: Colors.transparent,
                    child: Text("Are you not a teacher?", style: TextStyle(color: Colors.white, fontSize: 17)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 65,),
                ],
              )
          ),
        ],
      ),
    );

  }
}



class SubmitButton extends StatelessWidget {
  SubmitButton(this.text, this.onPress);
  final text;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          color: Colors.white,
          child: Text(text, style: TextStyle(fontSize: 25, color: PrimaryColor),),
          onPressed: onPress
        ),
      ),
    );
  }
}
