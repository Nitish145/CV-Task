import "package:cv_projects_task/signup_login_page.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  testWidgets("Renders", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SignUpLoginPage(),
      ),
    );

    expect(find.text("LOGIN"), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(FlatButton), findsOneWidget);

    final Finder emailField = find.widgetWithText(TextFormField, "Email");
    final Finder passwordField = find.widgetWithText(TextFormField, "Password");
    final Finder loginButton = find.widgetWithText(FlatButton, "LOGIN");

    expect(find.text("Login Successful"), findsNothing);

    await tester.enterText(emailField, "naggarwal@me.iitr.ac.in");
    await tester.enterText(passwordField, "Aggarwals@123");

    await tester.tap(loginButton);
    await tester.pump();

    // expect(find.text('Login Successful'), findsOneWidget);
  });

  testWidgets('Form requires email and password', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SignUpLoginPage(),
      ),
    );
    final Finder loginButton = find.widgetWithText(FlatButton, 'LOGIN');
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Email can\'t be empty'), findsOneWidget);
    expect(find.text('Password can\'t be empty'), findsOneWidget);
    expect(find.text('Login Successful'), findsNothing);
  });
}
