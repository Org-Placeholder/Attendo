import 'constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
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
  int _value = 1;
  String error_msg = "";
  @override
  Widget build(BuildContext context) {
    final email_controller = TextEditingController();
    final password_controller = TextEditingController();
    final confirm_password_controller = TextEditingController();
    Size size = MediaQuery.of(context).size;
    void submit()
    {
      print("username = " + email_controller.text + " password = " + password_controller.text + " cp = " + confirm_password_controller.text + "\n");
      if(_value == 1)
        {
          print("Teacher");
        }
      if(_value == 2)
      {
        print("Student");
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
                  SizedBox(height: 5,),
                  Text("So, you don't have an account?\nSign up below!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white), textAlign: TextAlign.center, ),
                  SizedBox(height: 25,),
                  Container(
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: PrimaryColor
                    ),
                    child: DropdownButton(
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      dropdownColor: PrimaryColor,
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("Teacher"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Student"),
                          value: 2,
                        )
                      ],
                      onChanged: (value)
                      {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
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
                  Container(
                    width: size.width * 0.8,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0
                      ),
                      controller: confirm_password_controller,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.work, size: 50, color: Colors.white),
                          labelText: "Confirm password",
                          labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white60)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(error_msg, style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600),),
                  SizedBox(height: 40,),
                  SubmitButton("Submit", submit),
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
          onPressed: onPress,
        ),
      ),
    );
  }
}
