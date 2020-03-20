import 'dart:convert';

import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/project_model_response.dart'
    as ProjectModel;
import 'package:cv_projects_task/models/projects_response.dart' as Projects;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Projects.ProjectsResponse> getPublicProjects() async {
  String endpoint = "/api/v0/public_projects";
  String uri = url + endpoint;
  try {
    var response = await client.get(
      uri,
      headers: header,
    );
    final jsonResponse = jsonDecode(response.body);
    Projects.ProjectsResponse projectsResponse =
        new Projects.ProjectsResponse.fromJson(jsonResponse);
    print(response.body);
    return projectsResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<ProjectModel.ProjectModelResponse> getPublicProjectDetails(
    int id) async {
  String endpoint = "/api/v0/public_projects/$id";
  String uri = url + endpoint;
  try {
    var response = await client.get(
      uri,
      headers: header,
    );
    final jsonResponse = jsonDecode(response.body);
    ProjectModel.ProjectModelResponse projectModelResponse =
        new ProjectModel.ProjectModelResponse.fromJson(jsonResponse);
    print(response.body);
    return projectModelResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Projects.ProjectsResponse> getMyProjects() async {
  String endpoint = "/api/v0/projects";
  String uri = url + endpoint;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    header.addAll({"Authorization": "Token $token"});
    var response = await client.get(
      uri,
      headers: header,
    );
    final jsonResponse = jsonDecode(response.body);
    Projects.ProjectsResponse projectsResponse =
        new Projects.ProjectsResponse.fromJson(jsonResponse);
    print(response.body);
    return projectsResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<ProjectModel.ProjectModelResponse> getMyProjectDetails(int id) async {
  String endpoint = "/api/v0/projects/$id";
  String uri = url + endpoint;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    header.addAll({"Authorization": "Token $token"});
    var response = await client.get(
      uri,
      headers: header,
    );
    final jsonResponse = jsonDecode(response.body);
    ProjectModel.ProjectModelResponse projectModelResponse =
        new ProjectModel.ProjectModelResponse.fromJson(jsonResponse);
    print(response.body);
    return projectModelResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
