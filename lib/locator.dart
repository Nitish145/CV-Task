import 'package:cv_projects_task/services/projects.dart';
import 'package:cv_projects_task/services/user.dart';
import 'package:cv_projects_task/viewmodels/login_model.dart';
import 'package:cv_projects_task/viewmodels/my_projects_model.dart';
import 'package:cv_projects_task/viewmodels/profile_model.dart';
import 'package:cv_projects_task/viewmodels/project_details_model.dart';
import 'package:cv_projects_task/viewmodels/public_projects_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ProjectsApi());
  locator.registerLazySingleton(() => UserApi());

  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => MyProjectsModel());
  locator.registerFactory(() => ProfileModel());
  locator.registerFactory(() => ProjectDetailsModel());
  locator.registerFactory(() => PublicProjectsModel());
}
