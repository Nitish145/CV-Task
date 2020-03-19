import 'package:cv_projects_task/Services/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpLoginPage extends StatefulWidget {
  @override
  _SignUpLoginPageState createState() => _SignUpLoginPageState();
}

class _SignUpLoginPageState extends State<SignUpLoginPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email, _password;
  bool _isLoginButtonTapped = false;
  bool _isLoginSuccessful = false;
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _showEmailInput() {
    return new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        labelText: "Email",
        labelStyle: Theme.of(context).primaryTextTheme.subhead,
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
        labelStyle: Theme.of(context).primaryTextTheme.subhead,
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

  Widget _showLoginButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: (_isLoginButtonTapped)
          ? new FlatButton(
              padding: EdgeInsets.all(8),
              color: Theme.of(context).primaryColor,
              child: new Text(
                'Authenticating...',
                style: Theme.of(context)
                    .accentTextTheme
                    .headline
                    .copyWith(color: Colors.white),
              ),
              onPressed: () {})
          : (_isLoginSuccessful)
              ? new FlatButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  shape: new Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                  child: new Text(
                    'Logged In Successfully',
                    style: Theme.of(context).primaryTextTheme.headline,
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
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  onPressed: _validateAndSubmit,
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

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      setState(() {
        _isLoginButtonTapped = true;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      userLogin(_email, _password).then((login) {
        if (login != null) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Login Successful !"),
          ));
          setState(() {
            _isLoginSuccessful = true;
            _isLoginButtonTapped = false;
          });
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString("token", login.token);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: new Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _showEmailInput(),
                      _showPasswordInput(),
                      Padding(
                        padding: const EdgeInsets.only(top: 45),
                        child: _showLoginButton(),
                      ),
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
