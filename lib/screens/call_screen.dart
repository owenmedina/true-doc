import 'package:flutter/material.dart';

import '../constants/strings_constants.dart';
import '../widgets/custom_app_bar.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(StringConstants.meetingScreenTitle),
      // body: ,
    );
  }
}