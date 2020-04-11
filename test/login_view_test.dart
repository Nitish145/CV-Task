import 'dart:convert';

import 'package:cv_projects_task/constants.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/ui/views/login_view.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_test_data.dart';

void main() {
  setUpAll(() {
    setupLocator();
  });

  Future<void> pumpLogInPage(WidgetTester tester, {http.Client client}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginView(
          client: client,
        ),
      ),
    );
  }

  Future<void> fillLoginDetailsAndTapLogin(
      WidgetTester tester, http.Client client) async {
    await pumpLogInPage(tester, client: client);

    final emailField = find.widgetWithText(TextFormField, "Email");
    final passwordField = find.widgetWithText(TextFormField, "Password");
    final loginButton = find.widgetWithText(FlatButton, "LOGIN");

    await tester.enterText(emailField, "testEmail");
    await tester.enterText(passwordField, "testPassword");
    await tester.tap(loginButton);
    await tester.pumpAndSettle(Duration(seconds: 1));
  }

  testWidgets("Renders", (WidgetTester tester) async {
    await pumpLogInPage(tester);

    expect(find.text("LOGIN"), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(FlatButton), findsOneWidget);
  });

  testWidgets('Form requires email and password', (WidgetTester tester) async {
    await pumpLogInPage(tester);

    final Finder loginButton = find.widgetWithText(FlatButton, 'LOGIN');
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Email can\'t be empty'), findsOneWidget);
    expect(find.text('Password can\'t be empty'), findsOneWidget);
    expect(find.text('Login Successful'), findsNothing);
  });

  testWidgets('Logs in checks for LoginResponse', (WidgetTester tester) async {
    MockClient mockClient = MockClient((request) async {
      return http.Response(json.encode(fakeLoginResponse), 202);
    });

    SharedPreferences.setMockInitialValues(
      {"isLoggedIn": false, "currentUserName": "mock User"},
    );

    await fillLoginDetailsAndTapLogin(tester, mockClient);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    expect(prefs.getBool("isLoggedIn"), true);
    expect(prefs.getString("currentUserName"), "Test User");
  });

  testWidgets('Log in failed for no user and checks for "No User Found"',
      (WidgetTester tester) async {
    MockClient mockClient = MockClient((request) async {
      return http.Response('Not found', 404);
    });
    await fillLoginDetailsAndTapLogin(tester, mockClient);

    expect(find.text(Constants.USER_AUTH_USER_NOT_FOUND), findsOneWidget);
  });
}
