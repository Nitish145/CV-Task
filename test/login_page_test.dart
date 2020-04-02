import 'dart:convert';

import "package:cv_projects_task/login_page.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

const fakeLoginResponse = {
  "token": "test_token",
  "exp": "04-02-2021 00:00",
  "username": "Test User"
};

void main() {
  Future<void> pumpLogInPage(WidgetTester tester, {http.Client client}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(
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

  testWidgets('Logs in checks for "Login Successful"',
      (WidgetTester tester) async {
    MockClient mockClient = MockClient((request) async {
      return http.Response(json.encode(fakeLoginResponse), 202);
    });
    await fillLoginDetailsAndTapLogin(tester, mockClient);

    expect(find.text("Login Successful"), findsOneWidget);
  });

  testWidgets(
      'Log in failed and checks for "Authentication details were not correct"',
      (WidgetTester tester) async {
    MockClient mockClient = MockClient((request) async {
      return http.Response('Not found', 404);
    });
    await fillLoginDetailsAndTapLogin(tester, mockClient);

    expect(
        find.text("Authentication details were not correct"), findsOneWidget);
  });
}
