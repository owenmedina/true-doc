import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/physician.dart';
import '../../providers/physicians.dart';
import '../../utilities/specialty_utility.dart';
import '../../utilities/constants/strings_constants.dart';

class CallForm extends StatefulWidget {
  final Function onSubmit;

  CallForm(this.onSubmit);

  @override
  _CallFormState createState() => _CallFormState();
}

class _CallFormState extends State<CallForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _meetingData = {
    'channelName': '',
    'displayName': '',
    'callee': null,
  };
  final _displayNameFocus = FocusNode();
  final _calleeFocus = FocusNode();
  var _tryingToSubmit = false;
  var _selectedRecipient;
  bool _isLoading = false;
  bool _isInitialized = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Physicians>(context, listen: false).fetchAndSetPhysicians();
      setState(() {
        _isLoading = false;
      });
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Physicians>(
                    builder: (ctx, physicians, child) =>
                        DropdownButton<dynamic>(
                      hint: Text(StringConstants.recipientHint),
                      value: _selectedRecipient,
                      focusNode: _calleeFocus,
                      items: physicians.physicians.map((e) => DropdownMenuItem(
                            child: Text('${e.firstName} ${e.lastName}'),
                            value: e,
                          )).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          _selectedRecipient = value;
                        });
                        _meetingData['callee'] = value;
                        print('Callee value: ${_meetingData['callee']}');
                      },
                    ),
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
