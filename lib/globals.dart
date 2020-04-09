import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String url = "https://2890791b.ngrok.io";

Map<int, Color> color = {
  50: Color.fromRGBO(66, 185, 131, .1),
  100: Color.fromRGBO(66, 185, 131, .2),
  200: Color.fromRGBO(66, 185, 131, .3),
  300: Color.fromRGBO(66, 185, 131, .4),
  400: Color.fromRGBO(66, 185, 131, .5),
  500: Color.fromRGBO(66, 185, 131, .6),
  600: Color.fromRGBO(66, 185, 131, .7),
  700: Color.fromRGBO(66, 185, 131, .8),
  800: Color.fromRGBO(66, 185, 131, .9),
  900: Color.fromRGBO(66, 185, 131, 1),
};

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// Global Scaffold Keys

final GlobalKey<ScaffoldState> homeViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> loginViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> publicProjectsViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> myProjectsViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> profileViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> projectDetailsViewScaffoldKey =
    new GlobalKey<ScaffoldState>();

// global function to show snackbar
void showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String _message) {
  _scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(_message),
  ));
}
