import 'dart:convert';

import 'package:cv_projects_task/models/user_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_test_data.dart';

void main() {
  group("Test User Response Model", () {
    UserResponse userResponse =
        userResponseFromJson(jsonEncode(fakeUserResponse));
    test("test userResponseFromJson", () {
      expect(userResponse.data.attributes.name, "test");
    });

    test("test ToJson", () {
      expect(fakeUserResponse, userResponse.toJson());
    });

    test("test userResponseToJson", () {
      expect(jsonEncode(fakeUserResponse), userResponseToJson(userResponse));
    });
  });
}
