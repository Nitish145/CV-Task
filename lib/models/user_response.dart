// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  Data data;

  UserResponse({
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String type;
  Attributes attributes;

  Data({
    this.id,
    this.type,
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  int id;
  String email;
  dynamic name;
  bool admin;
  dynamic country;
  dynamic educationalInstitute;
  bool subscribed;
  DateTime createdAt;
  DateTime updatedAt;

  Attributes({
    this.id,
    this.email,
    this.name,
    this.admin,
    this.country,
    this.educationalInstitute,
    this.subscribed,
    this.createdAt,
    this.updatedAt,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        admin: json["admin"],
        country: json["country"],
        educationalInstitute: json["educational_institute"],
        subscribed: json["subscribed"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "admin": admin,
        "country": country,
        "educational_institute": educationalInstitute,
        "subscribed": subscribed,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
