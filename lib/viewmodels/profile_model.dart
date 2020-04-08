import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/models/user_response.dart';
import 'package:cv_projects_task/services/user.dart';
import 'package:cv_projects_task/viewmodels/base_model.dart';
import 'package:http/http.dart' as http;

class ProfileModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();

  UserResponse userProfile;

  Future getUserProfile(
      {String email, String password, http.Client client}) async {
    setState(ViewState.Busy);
    try {
      userProfile = await _userApi.userMeGet(httpClient: client);
      setState(ViewState.Idle);
    } on Exception catch (e) {
      print(e);
      setState(ViewState.Error);
      setErrorMessage("Something Went Wrong! Please try again later");
    }
  }
}
