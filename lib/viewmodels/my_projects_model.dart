import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/models/projects_response.dart';
import 'package:cv_projects_task/services/projects.dart';
import 'package:cv_projects_task/viewmodels/base_model.dart';
import 'package:http/http.dart' as http;

class MyProjectsModel extends BaseModel {
  final ProjectsApi _projectsApi = locator<ProjectsApi>();

  bool _isNextPageLoading = false;

  bool get isNextPageLoading => _isNextPageLoading;

  set isNextPageLoading(bool isNextPageLoading) {
    _isNextPageLoading = isNextPageLoading;
    notifyListeners();
  }

  ProjectsResponse _myProjects;

  ProjectsResponse get myProjects => _myProjects;

  set setMyProjects(ProjectsResponse myProjects) {
    _myProjects = myProjects;
  }

  Future getMyProjects(int page, {http.Client client}) async {
    setState(ViewState.Busy);
    try {
      if (page > 1) _isNextPageLoading = true;
      _myProjects = await _projectsApi.getMyProjects(page, httpClient: client);
      _isNextPageLoading = false;
      setState(ViewState.Idle);
    } on Exception catch (e) {
      print(e);
      setErrorMessage("Something Went Wrong! Please try again later");
      setState(ViewState.Error);
    }
  }
}
