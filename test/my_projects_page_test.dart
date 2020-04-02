import 'dart:convert';

import 'package:cv_projects_task/components/project_card.dart';
import 'package:cv_projects_task/my_projects_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:image_test_utils/image_test_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_test_data.dart';

main() {
  Future<void> pumpMyProjectsPage(
      WidgetTester tester, http.Client client) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyProjectsPage(client: client),
      ),
    );
  }

  group('Tests My Projects API call and relevant widget renders', () {
    testWidgets('load and shows my projects', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        MockClient mockClient = MockClient((request) async {
          return http.Response(json.encode(fakeProjectsResponse), 200);
        });
        SharedPreferences.setMockInitialValues({"token": "test_token"});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", "test_token");
        await pumpMyProjectsPage(tester, mockClient);
        await tester.pumpAndSettle();

        expect(find.byType(ProjectCard), findsNWidgets(2));
      });
    });

    testWidgets('loads and shows an error', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        MockClient mockClient = MockClient((request) async {
          return http.Response('Not Found', 404);
        });
        await pumpMyProjectsPage(tester, mockClient);
        await tester.pumpAndSettle();

        expect(find.text("Something Went Wrong! Please try again later"),
            findsOneWidget);
      });
    });
  });
}
