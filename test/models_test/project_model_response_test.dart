import 'dart:convert';

import 'package:cv_projects_task/models/project_model_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_test_data.dart';

void main() {
  group("Test Project Response Model", () {
    ProjectModelResponse projectModelResponse =
        projectModelResponseFromJson(jsonEncode(fakeProjectDetailsResponse));
    test("test projectModelResponseFromJson", () {
      expect(projectModelResponse.data.attributes.name, "Test Title");
    });

    test("test ToJson", () {
      expect(fakeProjectDetailsResponse, projectModelResponse.toJson());
    });

    test("test projectModelResponseToJson", () {
      expect(jsonEncode(fakeProjectDetailsResponse),
          projectModelResponseToJson(projectModelResponse));
    });
  });
}
