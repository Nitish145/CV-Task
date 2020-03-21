import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/signup_login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circuitverse Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          Color.fromRGBO(66, 185, 131, 1).value,
          color,
        ),
        primaryColorDark: Color.fromRGBO(2, 110, 87, 1),
        cursorColor: Color.fromRGBO(66, 185, 131, 1),
        fontFamily: 'Raleway',
        primaryTextTheme: TextTheme(
          headline: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          subhead: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
          display1: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          display2: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          display3: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          display4: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          body1: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
          body2: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      home: SafeArea(child: SignUpLoginPage()),
    );
  }
}
