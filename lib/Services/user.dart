import 'dart:convert';

import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/login.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/vnd.api+json"};
http.Client client = new http.Client();

Future<Login> userLogin(String email, String pass) async {
  String endpoint = "/api/v0/auth/login";
  String uri = url + endpoint;
  var json = {
    "email": email,
    "password": pass,
  };
  try {
    var response = await client.post(
      uri,
      headers: header,
      body: jsonEncode(json),
    );
    final jsonResponse = jsonDecode(response.body);
    Login login = new Login.fromJson(jsonResponse);
    print(response.body);
    if (response.statusCode == 202) {
      return login;
    }
    return null;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
