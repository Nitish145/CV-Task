import "package:cv_projects_task/login_page.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  Future<void> pumpLogInPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );
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
}
