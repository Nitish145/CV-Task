import 'dart:convert';

import 'package:cv_projects_task/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_test_data.dart';

void main() {
  Future<void> pumpProfilePage(WidgetTester tester, http.Client client) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProfilePage(client: client),
      ),
    );
  }

  group("Tests User Profile API call and relevant widget renders", () {
    testWidgets('loads and shows user profile', (WidgetTester tester) async {
      MockClient mockClient = MockClient((request) async {
        return http.Response(json.encode(fakeUserResponse), 200);
      });
      SharedPreferences.setMockInitialValues({"token": "test_token"});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", "test_token");
      await pumpProfilePage(tester, mockClient);
      await tester.pumpAndSettle();

      expect(find.text("test"), findsOneWidget);
      expect(find.text("test@test.com"), findsOneWidget);
    });

    testWidgets('loads and shows an error', (WidgetTester tester) async {
      MockClient mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });
      await pumpProfilePage(tester, mockClient);
      await tester.pumpAndSettle();

      expect(find.text("Something Went Wrong! Please try again later"),
          findsOneWidget);
    });
  });
}
