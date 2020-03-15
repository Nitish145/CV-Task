// To parse this JSON data, do
//
//     final projectDetails = projectDetailsFromJson(jsonString);

import 'dart:convert';

ProjectDetails projectDetailsFromJson(String str) =>
    ProjectDetails.fromJson(json.decode(str));

String projectDetailsToJson(ProjectDetails data) => json.encode(data.toJson());

class ProjectDetails {
  int id;
  String name;
  int authorId;
  dynamic forkedProjectId;
  String projectAccessType;
  String data;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic assignmentId;
  bool projectSubmission;
  ImagePreview imagePreview;
  String description;
  int view;
  Author author;

  ProjectDetails({
    this.id,
    this.name,
    this.authorId,
    this.forkedProjectId,
    this.projectAccessType,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.assignmentId,
    this.projectSubmission,
    this.imagePreview,
    this.description,
    this.view,
    this.author,
  });

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        id: json["id"],
        name: json["name"],
        authorId: json["author_id"],
        forkedProjectId: json["forked_project_id"],
        projectAccessType: json["project_access_type"],
        data: json["data"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        assignmentId: json["assignment_id"],
        projectSubmission: json["project_submission"],
        imagePreview: ImagePreview.fromJson(json["image_preview"]),
        description: json["description"],
        view: json["view"],
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "author_id": authorId,
        "forked_project_id": forkedProjectId,
        "project_access_type": projectAccessType,
        "data": data,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "assignment_id": assignmentId,
        "project_submission": projectSubmission,
        "image_preview": imagePreview.toJson(),
        "description": description,
        "view": view,
        "author": author.toJson(),
      };
}

class Author {
  String email;
  String name;

  Author({
    this.email,
    this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
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
