import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../services/auth.dart';
import '../../utilities/constants/string_constants.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _isLogin = true;
  var _tryingToSubmit = false;
  final _formKey = GlobalKey<FormState>();
  final _authData = {
    'email': '',
    'password': '',
    'firstName': '',
    'lastName': '',
  };
  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Please enter a valid email'),
  ]);
  final _passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Password is required'),
      MinLengthValidator(8, errorText: 'Must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'Must have at least one special character'),
    ],
  );

  void _trySubmit() {
    setState(() {
      _tryingToSubmit = true;
    });
    if (!_formKey.currentState.validate()) {
      _tryingToSubmit = false;
      return;
    }
    _formKey.currentState.save();
    Auth.authenticate(
      _authData['email'],
      _authData['password'],
      _authData['firstName'],
      _authData['lastName'],
      _isLogin,
    );
    // TODO: push credentials to db
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonTextSize = screenSize.height * 0.025;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            TextFormField(
              key: ValueKey('email'),
              decoration: InputDecoration(
                hintText: 'Email',
              ),
              validator: _emailValidator,
              onSaved: (email) {
                _authData['email'] = email;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context)
                    .requestFocus(_isLogin ? passwordFocus : firstNameFocus);
              },
            ),
            SizedBox(
                height: _isLogin
                    ? screenSize.height * 0.05
                    : screenSize.height * 0.01),
            if (!_isLogin)
              TextFormField(
                key: ValueKey('firstName'),
                focusNode: firstNameFocus,
                decoration: InputDecoration(hintText: 'First Name'),
                validator:
                    RequiredValidator(errorText: 'First name is required'),
                onSaved: (firstName) {
                  _authData['firstName'] = firstName;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(lastNameFocus);
                },
              ),
            if (!_isLogin) SizedBox(height: screenSize.height * 0.01),
            if (!_isLogin)
              TextFormField(
                key: ValueKey('lastName'),
                focusNode: lastNameFocus,
                decoration: InputDecoration(hintText: 'Last Name'),
                validator:
                    RequiredValidator(errorText: 'Last name is required'),
                onSaved: (lastName) {
                  _authData['lastName'] = lastName;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocus);
                },
              ),
            if (!_isLogin)
              SizedBox(
                  height: _isLogin
                      ? screenSize.height * 0.05
                      : screenSize.height * 0.01),
            TextFormField(
              key: ValueKey('password'),
              focusNode: passwordFocus,
              decoration: InputDecoration(hintText: 'Password'),
              validator: _passwordValidator,
              onSaved: (password) {
                _authData['password'] = password;
              },
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: screenSize.height * 0.09),
            _tryingToSubmit
                ? Center(child: CircularProgressIndicator())
                : RaisedButton(
                    child: Text(
                      _isLogin ? StringConstants.logIn : StringConstants.signUp,
                      style: TextStyle(fontSize: buttonTextSize),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: _trySubmit,
                    padding: EdgeInsets.symmetric(
                      vertical: buttonTextSize * 0.8,
                      horizontal: buttonTextSize,
                    ),
                  ),
            SizedBox(height: screenSize.height * 0.01),
            Container(
              alignment: Alignment.center,
              width: screenSize.width * 0.5,
              child: FlatButton(
                child: Text(
                  _isLogin
                      ? StringConstants.signUpPrompt
                      : StringConstants.logInPrompt,
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
