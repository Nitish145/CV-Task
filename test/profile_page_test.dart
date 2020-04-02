import 'dart:convert';

import 'package:cv_projects_task/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const fakeUserMeGet = {
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "id": 1,
      "email": "test@test.com",
      "name": "test",
      "admin": true,
      "country": "IN",
      "educational_institute": "Indian Institute of Technology Roorkee",
      "subscribed": false,
      "created_at": "2020-02-04T21:27:07.041Z",
      "updated_at": "2020-03-30T15:07:22.487Z"
    }
  }
};

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
        return http.Response(json.encode(fakeUserMeGet), 200);
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