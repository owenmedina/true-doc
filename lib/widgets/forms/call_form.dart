import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../constants/strings_constants.dart';
import '../../models/app_user.dart';
import '../../services/patient.dart';

class CallForm extends StatefulWidget {
  final Function onSubmit;

  CallForm(this.onSubmit);

  @override
  _CallFormState createState() => _CallFormState();
}

class _CallFormState extends State<CallForm> {
  final _formKey = GlobalKey<FormState>();
  final _meetingData = {
    'channelName': '',
    'displayName': '',
    'callee': '',
  };
  final _displayNameFocus = FocusNode();
  final _calleeFocus = FocusNode();
  var _tryingToSubmit = false;
  var _selectedRecipient;

  void _submit() {
    setState(() {
      _tryingToSubmit = true;
    });
    if (!_formKey.currentState.validate()) {
      setState(() {
        _tryingToSubmit = false;
      });
      return;
    }
    _formKey.currentState.save();
    widget.onSubmit(
      _meetingData['channelName'],
      _meetingData['displayName'],
      _meetingData['callee'],
    );
    setState(() {
      _tryingToSubmit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Patient().getPhysicians();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Container(
      height: screenHeight * 0.90,
      width: screenWidth,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: screenHeight * 0.1, vertical: screenHeight * 0.05),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: ValueKey('channelName'),
              validator:
                  RequiredValidator(errorText: 'Channel Name is required'),
              onSaved: (channelName) {
                _meetingData['channelName'] = channelName;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_displayNameFocus);
              },
              decoration:
                  InputDecoration(hintText: StringConstants.channelNameHint),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: screenHeight * 0.05),
            TextFormField(
              key: ValueKey('displayName'),
              focusNode: _displayNameFocus,
              onSaved: (displayName) {
                _meetingData['displayName'] = displayName;
              },
              decoration:
                  InputDecoration(hintText: StringConstants.displayNameHint),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: screenHeight * 0.05),
            DropdownButton<AppUser>(
              hint: Text(StringConstants.recipientHint),
              value: _selectedRecipient,
              focusNode: _calleeFocus,
              items: [],
              onChanged: (AppUser value) {
                setState(() {
                  _selectedRecipient = value;
                });
                _meetingData['callee'] = value.id;
              },
            ),
            SizedBox(height: screenHeight * 0.1),
            _tryingToSubmit
                ? Center(child: CircularProgressIndicator())
                : RaisedButton(
                    padding: EdgeInsets.all(screenHeight * 0.02),
                    onPressed: _submit,
                    child: Text(
                      StringConstants.startCall,
                      style: TextStyle(fontSize: screenHeight * 0.025),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
