import 'package:attendo/screens/professor-home-page.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/auth.dart';
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
      home: AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

