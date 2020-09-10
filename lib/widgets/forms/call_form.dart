import 'package:flutter/material.dart';

import '../../constants/strings_constants.dart';

class CallForm extends StatefulWidget {
  @override
  _CallFormState createState() => _CallFormState();
}

class _CallFormState extends State<CallForm> {
  final _formKey = GlobalKey<FormState>();
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
              decoration:
                  InputDecoration(hintText: StringConstants.channelNameHint),
            ),
            SizedBox(height: screenHeight * 0.05),
            TextFormField(
              key: ValueKey('blah'),
              decoration:
                  InputDecoration(hintText: StringConstants.channelNameHint),
            ),
            SizedBox(height: screenHeight * 0.1),
            RaisedButton(
              padding: EdgeInsets.all(screenHeight * 0.02),
              onPressed: () {},
              child: Text(
                StringConstants.joinMeeting,
                style: TextStyle(fontSize: screenHeight * 0.025),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
