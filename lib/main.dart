import 'package:attendo/screens/professor-course-page.dart';
import 'package:attendo/screens/professor-home-page.dart';
import 'package:attendo/screens/student-home-page.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/auth.dart';
import 'package:attendo/screens/registration.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialize the app when main loads (for latest versions)
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

