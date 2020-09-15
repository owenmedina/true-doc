import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../utilities/constants/strings_constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(StringConstants.homeScreenTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Auth.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Home screen to be completed'),
      ),
    );
  }
}
