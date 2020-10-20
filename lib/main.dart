import 'package:flutter/material.dart';
import 'package:attendo/screens/auth.dart';
import 'package:attendo/screens/constants.dart';
import 'package:attendo/screens/networking.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NetScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

