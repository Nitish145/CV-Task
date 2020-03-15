import 'dart:convert';

import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/project_details.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<ProjectDetails> getProjectDetails(int id) async {
  String endpoint = "/api/v0/projects/$id";
  String uri = url + endpoint;
  try {
    var response = await client.get(
      uri,
      headers: header,
    );
    final jsonResponse = jsonDecode(response.body);
    ProjectDetails projectDetails = new ProjectDetails.fromJson(jsonResponse);
    print(response.body);
    return projectDetails;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<List<ProjectDetails>> getPublicProjects() async {
  String endpoint = "/api/v0/projects";
  String uri = url + endpoint;
  try {
    var response = await client.get(
      uri,
      headers: header,
    );
    final jsonResponse = jsonDecode(response.body);
    List<ProjectDetails> publicProjects = new List<ProjectDetails>.from(
      jsonResponse.map((x) => ProjectDetails.fromJson(x)),
    );
    print(response.body);
    return publicProjects;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
