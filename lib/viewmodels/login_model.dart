import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/models/failure_model.dart';
import 'package:cv_projects_task/models/login_response.dart';
import 'package:cv_projects_task/services/user.dart';
import 'package:cv_projects_task/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();

  LoginResponse _loginResponse;

  LoginResponse get loginResponse => _loginResponse;

  set loginResponse(LoginResponse loginResponse) {
    _loginResponse = loginResponse;
    notifyListeners();
  }

  bool _isLoginSuccessful = false;

  bool get isLoginSuccessful => _isLoginSuccessful;

  set isLoginSuccessful(bool isLoginSuccessful) {
    _isLoginSuccessful = isLoginSuccessful;
    notifyListeners();
  }

  Future login({String email, String password, http.Client client}) async {
    setState(ViewState.Busy);
    try {
      loginResponse =
          await _userApi.userLogin(email, password, httpClient: client);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("isLoggedIn", true);
      preferences.setString("token", _loginResponse.token);
      preferences.setString("currentUserName", _loginResponse.username);
      print("TOKEN SAVED");
      _isLoginSuccessful = true;
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      isLoginSuccessful = false;
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
