import 'package:cv_projects_task/constants.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/failure_model.dart';
import 'package:cv_projects_task/models/project_model_response.dart'
    as ProjectModel;
import 'package:cv_projects_task/models/projects_response.dart' as Projects;
import 'package:cv_projects_task/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProjectsApi {
  var headers = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<Projects.ProjectsResponse> getPublicProjects(int page,
      {http.Client httpClient}) async {
    String endpoint = "/api/v0/public_projects?page=$page";
    String uri = url + endpoint;
    try {
      http.Client apiClient = httpClient == null ? client : httpClient;
      var jsonResponse = await ApiUtils.get(
        uri,
        client: apiClient,
        headers: headers,
      );
      Projects.ProjectsResponse projectsResponse =
          new Projects.ProjectsResponse.fromJson(jsonResponse);
      return projectsResponse;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Projects.ProjectsResponse> getMyProjects(int page,
      {http.Client httpClient}) async {
    String endpoint = "/api/v0/projects?page=$page";
    String uri = url + endpoint;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      headers.addAll({"Authorization": "Token $token"});
      http.Client apiClient = httpClient == null ? client : httpClient;
      var jsonResponse = await ApiUtils.get(
        uri,
        client: apiClient,
        headers: headers,
      );
      Projects.ProjectsResponse projectsResponse =
          new Projects.ProjectsResponse.fromJson(jsonResponse);
      return projectsResponse;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<ProjectModel.ProjectModelResponse> getProjectDetails(int id,
      {http.Client httpClient}) async {
    String endpoint = "/api/v0/public_projects/$id";
    String uri = url + endpoint;
    try {
      http.Client apiClient = httpClient == null ? client : httpClient;
      var jsonResponse = await ApiUtils.get(
        uri,
        client: apiClient,
        headers: headers,
      );
      ProjectModel.ProjectModelResponse projectModelResponse =
          new ProjectModel.ProjectModelResponse.fromJson(jsonResponse);
      return projectModelResponse;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
