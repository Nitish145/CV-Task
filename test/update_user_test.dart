import 'dart:convert';

import 'package:cv_projects_task/Services/user.dart';
import 'package:cv_projects_task/models/user_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_test_data.dart';

void main() {
  group("Tests User Update API call", () {
    test('updates user info and return status 202', () async {
      MockClient mockClient = MockClient((request) async {
        return http.Response(json.encode(fakeUserResponse), 202);
      });
      SharedPreferences.setMockInitialValues({"token": "test_token"});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", "test_token");

      UserResponse userResponse = await updateUser(httpClient: mockClient);
      expect(userResponse.data.attributes.name, "test");
    });

    test('throws exception on error', () async {
      MockClient mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });
      expect(updateUser(httpClient: mockClient), throwsException);
    });
  });
}
