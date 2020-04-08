import 'dart:convert';

import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/login_response.dart';
import 'package:cv_projects_task/models/user_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  var header = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<LoginResponse> userLogin(String email, String pass,
      {http.Client httpClient}) async {
    String endpoint = "/api/v0/auth/login";
    String uri = url + endpoint;
    var json = {
      "email": email,
      "password": pass,
    };
    try {
      http.Client apiClient = httpClient == null ? client : httpClient;
      var response = await apiClient.post(
        uri,
        headers: header,
        body: jsonEncode(json),
      );
      final jsonResponse = jsonDecode(response.body);
      LoginResponse loginResponse = new LoginResponse.fromJson(jsonResponse);
      print(response.body);
      if (response.statusCode == 202) {
        return loginResponse;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<UserResponse> userMeGet({http.Client httpClient}) async {
    String endpoint = "/api/v0/user/me";
    String uri = url + endpoint;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      header.addAll({"Authorization": "Token $token"});
      http.Client apiClient = httpClient == null ? client : httpClient;
      var response = await apiClient.get(
        uri,
        headers: header,
      );
      final jsonResponse = jsonDecode(response.body);
      UserResponse userResponse = new UserResponse.fromJson(jsonResponse);
      print(response.body);
      return userResponse;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<UserResponse> updateUser(
      {String name,
      String educationalInstitute,
      String country,
      bool isSubscribed,
      http.Client httpClient}) async {
    String endpoint = "/api/v0/user/me";
    String uri = url + endpoint;
    var json = {
      "name": name,
      "educational_institute": educationalInstitute,
      "country": country,
      "subscribed": isSubscribed
    };
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      header.addAll({"Authorization": "Token $token"});
      http.Client apiClient = httpClient == null ? client : httpClient;
      var response = await apiClient.patch(
        uri,
        headers: header,
        body: jsonEncode(json),
      );
      final jsonResponse = jsonDecode(response.body);
      UserResponse userResponse = new UserResponse.fromJson(jsonResponse);
      print(response.body);
      if (response.statusCode == 202) {
        return userResponse;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
