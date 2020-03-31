import 'dart:convert';

import 'package:cv_projects_task/Services/projects.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/projects_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

const fakeProjectsResponse = {
  "data": [
    {
      "id": "8",
      "type": "project",
      "attributes": {
        "name": "Test 2",
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
        "description": "<p>Hey there, Loving CircuitVerse</p>",
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
    }
  ],
  "included": [
    {
      "id": "3",
      "type": "author",
      "attributes": {
        "name": "Nitish Aggarwal",
        "email": "royalnitish31@gmail.com"
      },
      "relationships": {
        "projects": {
          "data": [
            {"id": "8", "type": "project"}
          ]
        }
      }
    },
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
    "total_count": 5
  }
};

main() {
  MockClient client;

  setUp(() {
    // I use this method to initialize my environment for the tests
    // basically api values and such
    client = MockClient();
  });

  tearDown(() {
    client.close();
    clearInteractions(client);
    reset(client);
    client = null;
  });

  group('fetchPublicProjects', () {
    String endpoint = "/api/v0/public_projects";
    String uri = url + endpoint;

    test('returns Public Projects if the http call completes successfully',
        () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(argThat(startsWith(uri)))).thenAnswer(
          (_) async => http.Response(json.encode(fakeProjectsResponse), 200));

      expect(await getPublicProjects(1, httpClient: client),
          const TypeMatcher<ProjectsResponse>());
    });

    test('throws an exception if the http call completes with an error', () {
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(argThat(startsWith(uri))))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(getPublicProjects(1, httpClient: client), throwsException);
    });
  });
}
