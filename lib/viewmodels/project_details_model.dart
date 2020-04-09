import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/models/failure_model.dart';
import 'package:cv_projects_task/models/project_model_response.dart';
import 'package:cv_projects_task/services/projects.dart';
import 'package:cv_projects_task/viewmodels/base_model.dart';
import 'package:http/http.dart' as http;

class ProjectDetailsModel extends BaseModel {
  final ProjectsApi _projectsApi = locator<ProjectsApi>();

  ProjectModelResponse _projectDetails;

  ProjectModelResponse get projectDetails => _projectDetails;

  set projectDetails(ProjectModelResponse projectDetails) {
    _projectDetails = projectDetails;
    notifyListeners();
  }

  Future getProjectDetails(int id, {http.Client client}) async {
    setState(ViewState.Busy);
    try {
      projectDetails =
          await _projectsApi.getProjectDetails(id, httpClient: client);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
