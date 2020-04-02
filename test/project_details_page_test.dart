import 'dart:convert';

import 'package:cv_projects_task/projects_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:image_test_utils/image_test_utils.dart';

const fakePublicProjectDetails = {
  "data": {
    "id": "8",
    "type": "project",
    "attributes": {
      "name": "Test Title",
      "project_access_type": "Public",
      "created_at": "2020-03-18T17:26:26.312Z",
      "updated_at": "2020-03-18T17:26:26.312Z",
      "image_preview": {"url": "/img/default.png"},
      "description": null,
      "view": 1,
      "tags": [],
      "stars_count": 0
    },
    "relationships": {
      "author": {
        "data": {"id": "3", "type": "author"}
      }
    }
  },
  "included": [
    {
      "id": "3",
      "type": "author",
      "attributes": {"name": "Test User", "email": "test@test.com"},
      "relationships": {
        "projects": {
          "data": [
            {"id": "8", "type": "project"}
          ]
        }
      }
    }
  ]
};

void main() {
  Future<void> pumpProjectDetailsPage(
      WidgetTester tester, http.Client client) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProjectDetailPage(id: 1, client: client),
      ),
    );
  }

  group("Tests Project Details API call and relevant widget renders", () {
    testWidgets('loads and shows project details', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        MockClient mockClient = MockClient((request) async {
          return http.Response(json.encode(fakePublicProjectDetails), 200);
        });
        await pumpProjectDetailsPage(tester, mockClient);
        await tester.pumpAndSettle();

        expect(find.text("Test Title"), findsOneWidget);
      });
    });

    testWidgets('loads and shows an error', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        MockClient mockClient = MockClient((request) async {
          return http.Response('Not Found', 404);
        });
        await pumpProjectDetailsPage(tester, mockClient);
        await tester.pumpAndSettle();

        expect(find.text("Something Went Wrong! Please try again later"),
            findsOneWidget);
      });
    });
  });
}
