import 'package:attendo/screens/add-course-dialogbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

class account_drawer extends StatelessWidget {
  final String Name;
  final String Email;
  final String ImageURL;
  account_drawer({this.Name, this.Email, this.ImageURL});
  //account_drawer({Key key, @required this.Name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                  color: PrimaryColor,
                ),
                accountName: Text(Name, textAlign: TextAlign.center,),
                accountEmail: Text(Email, textAlign: TextAlign.center,),
                currentAccountPicture: new CircleAvatar(
                  //backgroundImage: new NetworkImage(ImageURL),
                  child: Icon(Icons.account_circle, size: 60,),
                  backgroundColor: PrimaryColor,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          )
      ),
    );
  }
}
