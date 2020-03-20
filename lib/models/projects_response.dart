// To parse this JSON data, do
//
//     final projectsResponse = projectsResponseFromJson(jsonString);

import 'dart:convert';

ProjectsResponse projectsResponseFromJson(String str) =>
    ProjectsResponse.fromJson(json.decode(str));

String projectsResponseToJson(ProjectsResponse data) =>
    json.encode(data.toJson());

class ProjectsResponse {
  List<Datum> data;
  List<Included> included;
  Meta meta;

  ProjectsResponse({
    this.data,
    this.included,
    this.meta,
  });

  factory ProjectsResponse.fromJson(Map<String, dynamic> json) =>
      ProjectsResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        included: List<Included>.from(
            json["included"].map((x) => Included.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "included": List<dynamic>.from(included.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Datum {
  String id;
  String type;
  DatumAttributes attributes;
  DatumRelationships relationships;

  Datum({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        attributes: DatumAttributes.fromJson(json["attributes"]),
        relationships: DatumRelationships.fromJson(json["relationships"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
        "relationships": relationships.toJson(),
      };
}

class DatumAttributes {
  String name;
  String projectAccessType;
  DateTime createdAt;
  DateTime updatedAt;
  ImagePreview imagePreview;
  String description;
  int view;

  DatumAttributes({
    this.name,
    this.projectAccessType,
    this.createdAt,
    this.updatedAt,
    this.imagePreview,
    this.description,
    this.view,
  });

  factory DatumAttributes.fromJson(Map<String, dynamic> json) =>
      DatumAttributes(
        name: json["name"],
        projectAccessType: json["project_access_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imagePreview: ImagePreview.fromJson(json["image_preview"]),
        description: json["description"] == null ? null : json["description"],
        view: json["view"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "project_access_type": projectAccessType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image_preview": imagePreview.toJson(),
        "description": description == null ? null : description,
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

class DatumRelationships {
  Author author;

  DatumRelationships({
    this.author,
  });

  factory DatumRelationships.fromJson(Map<String, dynamic> json) =>
      DatumRelationships(
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
        name: json["name"] == null ? null : json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
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

class Meta {
  int currentPage;
  dynamic nextPage;
  dynamic prevPage;
  int totalPages;
  int totalCount;

  Meta({
    this.currentPage,
    this.nextPage,
    this.prevPage,
    this.totalPages,
    this.totalCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        prevPage: json["prev_page"],
        totalPages: json["total_pages"],
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "next_page": nextPage,
        "prev_page": prevPage,
        "total_pages": totalPages,
        "total_count": totalCount,
      };
}
