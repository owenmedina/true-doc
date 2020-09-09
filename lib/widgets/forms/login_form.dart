import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../constants/strings_constants.dart';
import '../../providers/auth.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final _authData = {
    'email': '',
    'password': '',
  };
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
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Provider.of<Auth>(context, listen: false).authenticate(
      _authData['email'],
      _authData['password'],
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
            ),
            SizedBox(height: screenSize.height * 0.05),
            TextFormField(
              key: ValueKey('password'),
              decoration: InputDecoration(hintText: 'Password'),
              validator: _passwordValidator,
              onSaved: (password) {
                _authData['password'] = password;
              },
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: screenSize.height * 0.09),
            RaisedButton(
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
                child: Text(_isLogin
                    ? StringConstants.signUpPrompt
                    : StringConstants.logInPrompt, textAlign: TextAlign.center,),
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
