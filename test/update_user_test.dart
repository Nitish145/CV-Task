import 'dart:convert';

import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/models/failure_model.dart';
import 'package:cv_projects_task/models/user_response.dart';
import 'package:cv_projects_task/services/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_test_data.dart';

void main() {
  group("Tests User Update API call", () {
    setUpAll(() {
      setupLocator();
    });

    var userApi = UserApi();
    testWidgets('updates user info and return status 202',
        (WidgetTester tester) async {
      MockClient mockClient = MockClient((request) async {
        return http.Response(json.encode(fakeUserResponse), 202);
      });
      SharedPreferences.setMockInitialValues({"token": "test_token"});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", "test_token");

      UserResponse userResponse =
          await userApi.updateUser(httpClient: mockClient);
      expect(userResponse.data.attributes.name, "test");
    });

    testWidgets('throws exception on error', (WidgetTester tester) async {
      MockClient mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      expect(userApi.updateUser(httpClient: mockClient),
          throwsA(isInstanceOf<Failure>()));
    });
  });
}
