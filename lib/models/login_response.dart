// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String token;
  String exp;
  dynamic username;

  LoginResponse({
    this.token,
    this.exp,
    this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        exp: json["exp"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "exp": exp,
        "username": username,
      };
}
