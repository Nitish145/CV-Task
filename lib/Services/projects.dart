import 'dart:convert';

import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/project_model_response.dart'
    as ProjectModel;
import 'package:cv_projects_task/models/projects_response.dart' as Projects;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Projects.ProjectsResponse> getPublicProjects(int page,
    {http.Client httpClient}) async {
  String endpoint = "/api/v0/public_projects?page=$page";
  String uri = url + endpoint;
  try {
    http.Client apiClient = httpClient == null ? client : httpClient;
    var response = await apiClient.get(
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
    throw Exception(e);
  }
}

Future<ProjectModel.ProjectModelResponse> getPublicProjectDetails(int id,
    {http.Client httpClient}) async {
  String endpoint = "/api/v0/public_projects/$id";
  String uri = url + endpoint;
  try {
    http.Client apiClient = httpClient == null ? client : httpClient;
    var response = await apiClient.get(
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
    throw Exception(e);
  }
}

Future<Projects.ProjectsResponse> getMyProjects(int page,
    {http.Client httpClient}) async {
  String endpoint = "/api/v0/projects?page=$page";
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
    Projects.ProjectsResponse projectsResponse =
        new Projects.ProjectsResponse.fromJson(jsonResponse);
    print(response.body);
    return projectsResponse;
  } on Exception catch (e) {
    print(e);
    throw Exception(e);
  }
}
