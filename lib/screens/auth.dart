import 'constants.dart';
import 'package:flutter/material.dart';

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
              SignUpSignInButton("Student Login"),
              SizedBox(height: 10,),
              SignUpSignInButton("Professor Login"),
              SizedBox(height: 150,),
            ],
          )

        ],
      ),
    );
  }
}

void signup()
{
  //yaba daba doo
}

class SignUpSignInButton extends StatelessWidget {
  SignUpSignInButton(this.text);
  final text;
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
          onPressed: signup,
        ),
      ),
    );
  }
}
