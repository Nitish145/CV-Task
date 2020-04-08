import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/locator.dart';
import 'package:cv_projects_task/models/login_response.dart';
import 'package:cv_projects_task/services/user.dart';
import 'package:cv_projects_task/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();

  bool _isLoginSuccessful = false;

  bool get isLoginSuccessful => _isLoginSuccessful;

  set isLoginSuccessful(bool isLoginSuccessful) {
    _isLoginSuccessful = isLoginSuccessful;
    notifyListeners();
  }

  Future<bool> login(
      {String email, String password, http.Client client}) async {
    setState(ViewState.Busy);
    try {
      LoginResponse _loginResponse =
          await _userApi.userLogin(email, password, httpClient: client);
      if (_loginResponse.toJson().containsKey("token")) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isLoggedIn", true);
        preferences.setString("token", _loginResponse.token);
        preferences.setString("currentUserName", _loginResponse.username);
        print("TOKEN SAVED");
        _isLoginSuccessful = true;
        setState(ViewState.Idle);
        return true;
      }

      _isLoginSuccessful = false;
      setErrorMessage("Authentication details were not correct");
      setState(ViewState.Error);

      return false;
    } on Exception catch (e) {
      print(e);
      _isLoginSuccessful = false;
      setErrorMessage("Something Went Wrong! Please try again later");
      setState(ViewState.Error);

      return false;
    }
  }
}
