import 'dart:convert';

import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/failure_model.dart';
import 'package:cv_projects_task/models/login_response.dart';
import 'package:cv_projects_task/models/user_response.dart';
import 'package:cv_projects_task/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cv_projects_task/utils/app_exceptions.dart';

class UserApi {
  var headers = {"Content-Type": "application/json"};
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
      var jsonResponse = await ApiUtils.post(
        uri,
        client: apiClient,
        headers: headers,
        body: jsonEncode(json),
      );
      LoginResponse loginResponse = new LoginResponse.fromJson(jsonResponse);
      return loginResponse;
    } on UnauthorizedException {
      throw Failure("Invalid Credentials, Please check.");
    } on NotFoundException {
      throw Failure("User Not found, try Signing Up.");
    } on FormatException {
      throw Failure("Bad Response Format");
    } on Exception {
      throw Failure("Something Wrong Occured! Please try again.");
    }
  }

  Future<UserResponse> userMeGet({http.Client httpClient}) async {
    String endpoint = "/api/v0/user/me";
    String uri = url + endpoint;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      headers.addAll({"Authorization": "Token $token"});
      http.Client apiClient = httpClient == null ? client : httpClient;
      var jsonResponse = await ApiUtils.get(
        uri,
        client: apiClient,
        headers: headers,
      );
      UserResponse userResponse = new UserResponse.fromJson(jsonResponse);
      return userResponse;
    } on UnauthorizedException {
      throw Failure("You are not authorized to fetch this User");
    } on NotFoundException {
      throw Failure("No User Found");
    } on FormatException {
      throw Failure("Bad Response Format");
    } on Exception {
      throw Failure("Something Wrong Occured! Please try again.");
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
      headers.addAll({"Authorization": "Token $token"});
      http.Client apiClient = httpClient == null ? client : httpClient;
      var jsonResponse = await ApiUtils.patch(
        uri,
        client: apiClient,
        headers: headers,
        body: jsonEncode(json),
      );
      UserResponse userResponse = new UserResponse.fromJson(jsonResponse);
      return userResponse;
    } on FormatException {
      throw Failure("Bad Response Format");
    } on Exception {
      throw Failure("Something Wrong Occured! Please try again.");
    }
  }
}
