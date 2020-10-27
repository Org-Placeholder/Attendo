import 'constants.dart';
import 'package:flutter/material.dart';

class ProfessorLoginScreen extends StatelessWidget {
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
    final email_controller = TextEditingController();
    final password_controller = TextEditingController();
    Size size = MediaQuery.of(context).size;
    void submit()
    {
      print("username = " + email_controller.text + " password = " + password_controller.text);
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
                  SizedBox(height: 40,),
                  SignUpSignInButton("Submit", submit),
                  SizedBox(height: 65,),
                ],
              )
          ),
        ],
      ),
    );

  }

}



class SignUpSignInButton extends StatelessWidget {
  SignUpSignInButton(this.text, this.onPress);
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
          onPressed: onPress,
        ),
      ),
    );
  }
}
