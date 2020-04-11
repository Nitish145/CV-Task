import 'dart:convert';

import 'package:cv_projects_task/constants.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/ui/components/project_card.dart';
import 'package:cv_projects_task/ui/views/public_projects_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:image_test_utils/image_test_utils.dart';

import 'fake_test_data.dart';

main() {
  setUpAll(() {
    setupLocator();
  });

  Future<void> pumpPublicProjectsView(
      WidgetTester tester, http.Client client) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PublicProjectsView(client: client),
      ),
    );
  }

  group('Tests Public Projects API call and relevant widget renders', () {
    testWidgets('load and shows public projects', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        MockClient mockClient = MockClient((request) async {
          return http.Response(json.encode(fakeProjectsResponse), 200);
        });
        await pumpPublicProjectsView(tester, mockClient);
        await tester.pumpAndSettle();

        expect(find.byType(ProjectCard), findsNWidgets(2));
      });
    });

    testWidgets('loads and shows an error', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        MockClient mockClient = MockClient((request) async {
          return http.Response('Not Found', 404);
        });
        await pumpPublicProjectsView(tester, mockClient);
        await tester.pumpAndSettle();

        expect(find.text(Constants.GENERIC_FAILURE), findsNWidgets(2));
      });
    });
  });
}
