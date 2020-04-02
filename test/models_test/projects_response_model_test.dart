import 'dart:convert';

import 'package:cv_projects_task/models/projects_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_test_data.dart';

void main() {
  group("Test Projects Response Model", () {
    ProjectsResponse projectsResponse =
        projectsResponseFromJson(jsonEncode(fakeProjectsResponse));
    test("test projectsResponseFromJson", () {
      expect(projectsResponse.data.length, 3);
    });

    test("test ToJson", () {
      expect(fakeProjectsResponse, projectsResponse.toJson());
    });

    test("test projectsResponseToJson", () {
      expect(jsonEncode(fakeProjectsResponse),
          projectsResponseToJson(projectsResponse));
    });
  });
}
