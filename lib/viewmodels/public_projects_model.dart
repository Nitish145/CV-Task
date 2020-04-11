import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/models/failure_model.dart';
import 'package:cv_projects_task/models/projects_response.dart';
import 'package:cv_projects_task/services/projects.dart';
import 'package:cv_projects_task/viewmodels/base_model.dart';
import 'package:http/http.dart' as http;

class PublicProjectsModel extends BaseModel {
  final ProjectsApi _projectsApi = locator<ProjectsApi>();

  bool _isNextPageLoading = false;

  bool get isNextPageLoading => _isNextPageLoading;

  set isNextPageLoading(bool isNextPageLoading) {
    _isNextPageLoading = isNextPageLoading;
    notifyListeners();
  }

  ProjectsResponse _publicProjects;

  ProjectsResponse get publicProjects => _publicProjects;

  set publicProjects(ProjectsResponse publicProjects) {
    _publicProjects = publicProjects;
    notifyListeners();
  }

  Future<ProjectsResponse> getPublicProjects(int page,
      {http.Client client}) async {
    setState(ViewState.Busy);
    try {
      if (page > 1) isNextPageLoading = true;
      publicProjects =
          await _projectsApi.getPublicProjects(page, httpClient: client);
      isNextPageLoading = false;
      setState(ViewState.Idle);
      return publicProjects;
    } on Failure catch (f) {
      isNextPageLoading = false;
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
    return null;
  }
}
