import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/ui/router.dart';
import 'package:cv_projects_task/ui/views/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

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
      onGenerateRoute: Router.generateRoute,
      initialRoute: Router.initialRoute,
      home: Container(
        color: Color.fromRGBO(66, 185, 131, 1),
        child: SafeArea(
          child: HomeView(),
        ),
      ),
    );
  }
}
