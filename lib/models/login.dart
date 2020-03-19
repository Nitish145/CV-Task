// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String token;
  String exp;
  String username;

  Login({
    this.token,
    this.exp,
    this.username,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
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
