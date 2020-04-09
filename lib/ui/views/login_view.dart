import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/ui/views/base_view.dart';
import 'package:cv_projects_task/viewmodels/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginView extends StatefulWidget {
  final Client client;

  const LoginView({Key key, this.client}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = new GlobalKey<FormState>();
  String _email, _password;
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _signUpLogInImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "assets/images/sign_in.png",
        height: MediaQuery.of(context).size.height / 3,
      ),
    );
  }

  Widget _showEmailInput() {
    return new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        labelText: "Email",
        labelStyle: Theme.of(context).textTheme.headline,
        icon: new Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
      ),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      onSaved: (value) => _email = value.trim(),
    );
  }

  Widget _showPasswordInput() {
    return new TextFormField(
      maxLines: 1,
      obscureText: _obscureText,
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        suffixIcon: GestureDetector(
          child: new Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColor,
          ),
          onTap: _toggle,
        ),
        labelText: "Password",
        labelStyle: Theme.of(context).textTheme.headline,
        icon: new Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
      ),
      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _showLoginButton(LoginModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 45),
      width: MediaQuery.of(context).size.width,
      child: (model.state == ViewState.Busy)
          ? new FlatButton(
              padding: EdgeInsets.all(8),
              color: Theme.of(context).primaryColor,
              child: new Text(
                'Authenticating...',
                style: Theme.of(context).textTheme.headline.copyWith(
                      color: Colors.white,
                    ),
              ),
              onPressed: () {})
          : (model.isLoginSuccessful)
              ? new FlatButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  shape: new Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                  child: new Text(
                    'Logged In',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  onPressed: null)
              : new FlatButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  shape: new Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                  child: new Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  onPressed: () {
                    _validateAndSubmit(model);
                  },
                ),
    );
  }

  // Check if form is valid before performing Login
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void resetLogin(LoginModel model) {
    _formKey.currentState.reset();
    showSnackBar(loginViewScaffoldKey, model.errorMessage);
  }

  void _validateAndSubmit(LoginModel model) {
    if (_validateAndSave()) {
      FocusScope.of(context).requestFocus(new FocusNode());
      model
          .login(email: _email, password: _password, client: widget.client)
          .then((_) {
        if (model.isLoginSuccessful) {
          showSnackBar(loginViewScaffoldKey, "Login Successful");
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        } else {
          resetLogin(model);
        }
      }).catchError((e) {
        resetLogin(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        key: loginViewScaffoldKey,
        appBar: AppBar(
          title: Text("LogIn / SignUp"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: new Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _signUpLogInImage(),
                      _showEmailInput(),
                      _showPasswordInput(),
                      _showLoginButton(model),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
