import 'dart:convert';

import 'package:cv_projects_task/components/project_card.dart';
import 'package:cv_projects_task/my_projects_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:image_test_utils/image_test_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

const fakeMyProjectsResponse = {
  "data": [
    {
      "id": "9",
      "type": "project",
      "attributes": {
        "name": "Simple LED",
        "project_access_type": "Public",
        "created_at": "2020-03-19T04:16:53.543Z",
        "updated_at": "2020-03-22T07:14:03.161Z",
        "image_preview": {
          "url":
              "/uploads/project/image_preview/9/preview_2020-03-19_09_46_53_%2B0530.jpeg"
        },
        "description": " <p>Hey there, Loving Circuitverse</p>",
        "view": 1,
        "tags": [
          {
            "id": 1,
            "name": "CV",
            "created_at": "2020-03-10T13:02:10.381Z",
            "updated_at": "2020-03-10T13:02:10.381Z"
          },
        ],
        "stars_count": 1
      },
      "relationships": {
        "author": {
          "data": {"id": "1", "type": "author"}
        }
      }
    },
    {
      "id": "12",
      "type": "project",
      "attributes": {
        "name": "Nitish Aggarwal/Test",
        "project_access_type": "Private",
        "created_at": "2020-03-28T04:14:34.683Z",
        "updated_at": "2020-03-28T05:07:05.530Z",
        "image_preview": {"url": "/img/default.png"},
        "description": null,
        "view": 4,
        "tags": [],
        "stars_count": 1
      },
      "relationships": {
        "author": {
          "data": {"id": "1", "type": "author"}
        }
      }
    },
    {
      "id": "10",
      "type": "project",
      "attributes": {
        "name": "Test 3",
        "project_access_type": "Public",
        "created_at": "2020-03-21T18:55:54.528Z",
        "updated_at": "2020-03-28T04:51:21.479Z",
        "image_preview": {
          "url":
              "/uploads/project/image_preview/10/preview_2020-03-22_00_25_54_%2B0530.jpeg"
        },
        "description": "",
        "view": 2,
        "tags": [],
        "stars_count": 1
      },
      "relationships": {
        "author": {
          "data": {"id": "1", "type": "author"}
        }
      }
    }
  ],
  "included": [
    {
      "id": "1",
      "type": "author",
      "attributes": {"name": "Nitish", "email": "naggarwal@me.iitr.ac.in"},
      "relationships": {
        "projects": {
          "data": [
            {"id": "9", "type": "project"},
            {"id": "12", "type": "project"},
            {"id": "10", "type": "project"},
            {"id": "11", "type": "project"}
          ]
        }
      }
    }
  ],
  "meta": {
    "current_page": 1,
    "next_page": 2,
    "prev_page": null,
    "total_pages": 2,
    "total_count": 4
  }
};

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
          return http.Response(json.encode(fakeMyProjectsResponse), 200);
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
