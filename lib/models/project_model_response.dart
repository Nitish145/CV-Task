// To parse this JSON data, do
//
//     final projectModelResponse = projectModelResponseFromJson(jsonString);

import 'dart:convert';

ProjectModelResponse projectModelResponseFromJson(String str) =>
    ProjectModelResponse.fromJson(json.decode(str));

String projectModelResponseToJson(ProjectModelResponse data) =>
    json.encode(data.toJson());

class ProjectModelResponse {
  Data data;
  List<Included> included;

  ProjectModelResponse({
    this.data,
    this.included,
  });

  factory ProjectModelResponse.fromJson(Map<String, dynamic> json) =>
      ProjectModelResponse(
        data: Data.fromJson(json["data"]),
        included: List<Included>.from(
            json["included"].map((x) => Included.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "included": List<dynamic>.from(included.map((x) => x.toJson())),
      };
}

class Data {
  String id;
  String type;
  DataAttributes attributes;
  DataRelationships relationships;

  Data({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        attributes: DataAttributes.fromJson(json["attributes"]),
        relationships: DataRelationships.fromJson(json["relationships"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
        "relationships": relationships.toJson(),
      };
}

class DataAttributes {
  String name;
  String projectAccessType;
  DateTime createdAt;
  DateTime updatedAt;
  ImagePreview imagePreview;
  dynamic description;
  int view;

  DataAttributes({
    this.name,
    this.projectAccessType,
    this.createdAt,
    this.updatedAt,
    this.imagePreview,
    this.description,
    this.view,
  });

  factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
        name: json["name"],
        projectAccessType: json["project_access_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imagePreview: ImagePreview.fromJson(json["image_preview"]),
        description: json["description"],
        view: json["view"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "project_access_type": projectAccessType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image_preview": imagePreview.toJson(),
        "description": description,
        "view": view,
      };
}

class ImagePreview {
  String url;

  ImagePreview({
    this.url,
  });

  factory ImagePreview.fromJson(Map<String, dynamic> json) => ImagePreview(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class DataRelationships {
  Author author;

  DataRelationships({
    this.author,
  });

  factory DataRelationships.fromJson(Map<String, dynamic> json) =>
      DataRelationships(
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author.toJson(),
      };
}

class Author {
  Dat data;

  Author({
    this.data,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        data: Dat.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Dat {
  String id;
  String type;

  Dat({
    this.id,
    this.type,
  });

  factory Dat.fromJson(Map<String, dynamic> json) => Dat(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}

class Included {
  String id;
  String type;
  IncludedAttributes attributes;
  IncludedRelationships relationships;

  Included({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
  });

  factory Included.fromJson(Map<String, dynamic> json) => Included(
        id: json["id"],
        type: json["type"],
        attributes: IncludedAttributes.fromJson(json["attributes"]),
        relationships: IncludedRelationships.fromJson(json["relationships"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
        "relationships": relationships.toJson(),
      };
}

class IncludedAttributes {
  String name;
  String email;

  IncludedAttributes({
    this.name,
    this.email,
  });

  factory IncludedAttributes.fromJson(Map<String, dynamic> json) =>
      IncludedAttributes(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };
}

class IncludedRelationships {
  Projects projects;

  IncludedRelationships({
    this.projects,
  });

  factory IncludedRelationships.fromJson(Map<String, dynamic> json) =>
      IncludedRelationships(
        projects: Projects.fromJson(json["projects"]),
      );

  Map<String, dynamic> toJson() => {
        "projects": projects.toJson(),
      };
}

class Projects {
  List<Dat> data;

  Projects({
    this.data,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        data: List<Dat>.from(json["data"].map((x) => Dat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
