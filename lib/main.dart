import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/my_projects_page.dart';
import 'package:cv_projects_task/profile_page.dart';
import 'package:cv_projects_task/public_projects_page.dart';
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
      ),
      home: SafeArea(child: MyProjectsPage()),
    );
  }
}
