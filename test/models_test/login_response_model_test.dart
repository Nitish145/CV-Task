import 'dart:convert';

import 'package:cv_projects_task/models/login_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_test_data.dart';

void main() {
  group("Test Login Response Model", () {
    LoginResponse loginResponse =
        loginResponseFromJson(jsonEncode(fakeLoginResponse));
    test("test loginResponseFromJson", () {
      expect(loginResponse.token, "test_token");
    });

    test("test ToJson", () {
      expect(fakeLoginResponse, loginResponse.toJson());
    });

    test("test loginResponseToJson", () {
      expect(jsonEncode(fakeLoginResponse), loginResponseToJson(loginResponse));
    });
  });
}
