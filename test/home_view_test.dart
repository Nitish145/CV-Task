import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/keys.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/ui/components/feature_card.dart';
import 'package:cv_projects_task/ui/router.dart';
import 'package:cv_projects_task/ui/views/about_view.dart';
import 'package:cv_projects_task/ui/views/contributors_view.dart';
import 'package:cv_projects_task/ui/views/home_view.dart';
import 'package:cv_projects_task/ui/views/login_view.dart';
import 'package:cv_projects_task/ui/views/my_projects_view.dart';
import 'package:cv_projects_task/ui/views/profile_view.dart';
import 'package:cv_projects_task/ui/views/public_projects_view.dart';
import 'package:cv_projects_task/ui/views/teachers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mocks.dart';

void main() {
  NavigatorObserver mockObserver;

  setUpAll(() {
    setupLocator();
  });

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Future<void> pumpHomeView(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: Router.generateRoute,
        initialRoute: Router.initialRoute,
        home: HomeView(),
        navigatorObservers: [mockObserver],
      ),
    );

    /// The tester.pumpWidget() call above just built our app widget
    /// and triggered the pushObserver method on the mockObserver once.
    verify(mockObserver.didPush(any, any));
  }

  testWidgets("Home View Widgets", (WidgetTester tester) async {
    await pumpHomeView(tester);

    expect(find.text("Dive into the world of Logic Circuits for free!"),
        findsOneWidget);
    expect(find.byType(OutlineButton), findsNWidgets(2));
    expect(find.byType(FeatureCard), findsNWidgets(5));
  });

  Future<Null> _openHomePageDrawer(WidgetTester tester) async {
    await pumpHomeView(tester);
    homeViewScaffoldKey.currentState.openDrawer();
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
    testWidgets('when tapping "About" in drawer, should navigate to About View',
        (WidgetTester tester) async {
      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.aboutDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(AboutView), findsOneWidget);
    });

    testWidgets(
        'when tapping "Contribute" in drawer, should navigate to Contributors View',
        (WidgetTester tester) async {
      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.contributeDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(ContributorsView), findsOneWidget);
    });

    testWidgets(
        'when tapping "Teachers" in drawer, should navigate to Teachers View',
        (WidgetTester tester) async {
      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.teachersDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(TeachersView), findsOneWidget);
    });

    testWidgets(
        'when tapping "Public Projects" in drawer, should navigate to Public Projects View',
        (WidgetTester tester) async {
      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.publicProjectsDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(PublicProjectsView), findsOneWidget);
    });

    testWidgets('when tapping "Login" in drawer, should navigate to Login View',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({"isLoggedIn": false});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", false);

      await _openHomePageDrawer(tester);
      await tester.tap(find.byKey(Key(Keys.loginDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets(
        'when tapping "Profile" in expansion tile, should navigate to Profile View',
        (WidgetTester tester) async {
      await _openDrawerExpansionTile(tester);
      await tester.tap(find.byKey(Key(Keys.profileDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(ProfileView), findsOneWidget);
    });

    testWidgets(
        'when tapping "My Projects" in expansion tile, should navigate to MyProjects View',
        (WidgetTester tester) async {
      await _openDrawerExpansionTile(tester);
      await tester.tap(find.byKey(Key(Keys.myProjectsDrawerTile)));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(MyProjectsView), findsOneWidget);
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
