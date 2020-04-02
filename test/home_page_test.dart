import 'package:cv_projects_task/about_page.dart';
import 'package:cv_projects_task/components/feature_card.dart';
import 'package:cv_projects_task/contributors_page.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/home_page.dart';
import 'package:cv_projects_task/keys.dart';
import 'package:cv_projects_task/login_page.dart';
import 'package:cv_projects_task/my_projects_page.dart';
import 'package:cv_projects_task/profile_page.dart';
import 'package:cv_projects_task/public_projects_page.dart';
import 'package:cv_projects_task/teachers_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mocks.dart';

void main() {
  NavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Future<void> pumpHomePage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
        navigatorObservers: [mockObserver],
      ),
    );

    /// The tester.pumpWidget() call above just built our app widget
    /// and triggered the pushObserver method on the mockObserver once.
    verify(mockObserver.didPush(any, any));
  }

  testWidgets("Home Page Widgets", (WidgetTester tester) async {
    await pumpHomePage(tester);

    expect(find.text("Dive into the world of Logic Circuits for free!"),
        findsOneWidget);
    expect(find.byType(OutlineButton), findsNWidgets(2));
    expect(find.byType(FeatureCard), findsNWidgets(5));
  });

  Future<Null> _openHomePageDrawer(WidgetTester tester) async {
    await pumpHomePage(tester);
    homePageScaffoldKey.currentState.openDrawer();
    await tester.pumpAndSettle();
  }

  Future<Null> _openDrawerExpansionTile(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(
        {"isLoggedIn": true, "currentUserName": "Test"});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", true);
    prefs.setString("currentUserName", "Test");

    await _openHomePageDrawer(tester);
    await tester.tap(find.text("Test"));
    await tester.pumpAndSettle();
  }

  group('HomePage Drawer navigation tests', () {
    testWidgets('when tapping "About" in drawer, should navigate to About page',
        (WidgetTester tester) async {
      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.aboutDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(AboutPage), findsOneWidget);
    });

    testWidgets(
        'when tapping "Contribute" in drawer, should navigate to Contributors page',
        (WidgetTester tester) async {
      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.contributeDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(ContributorsPage), findsOneWidget);
    });

    testWidgets(
        'when tapping "Teachers" in drawer, should navigate to Teachers page',
        (WidgetTester tester) async {
      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.teachersDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(TeachersPage), findsOneWidget);
    });

    testWidgets(
        'when tapping "Public Projects" in drawer, should navigate to Public Projects page',
        (WidgetTester tester) async {
      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.publicProjectsDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(PublicProjectsPage), findsOneWidget);
    });

    testWidgets('when tapping "Login" in drawer, should navigate to Login page',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({"isLoggedIn": false});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", false);

      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.loginDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets(
        'when tapping "Profile" in expansion tile, should navigate to Profile page',
        (WidgetTester tester) async {
      await _openDrawerExpansionTile(tester);
      await tester.tap(find.byKey(Key(Keys.profileDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets(
        'when tapping "My Projects" in expansion tile, should navigate to MyProjects page',
        (WidgetTester tester) async {
      await _openDrawerExpansionTile(tester);
      await tester.tap(find.byKey(Key(Keys.myProjectsDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(MyProjectsPage), findsOneWidget);
    });

    testWidgets(
        'when tapping "Logout" in expansion tile, should show toast "Logged Out successfully"',
        (WidgetTester tester) async {
      await _openDrawerExpansionTile(tester);
      await tester.tap(find.byKey(Key(Keys.logoutDrawerTile)));
      await tester.pumpAndSettle();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      expect(prefs.getBool("isLoggedIn"), null);
      expect(prefs.getBool("currentUserName"), null);
    });
  });
}
