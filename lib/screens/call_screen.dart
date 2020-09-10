import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/strings_constants.dart';
import '../providers/auth.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(StringConstants.meetingScreenTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
      // body: ,
    );
  }
}
