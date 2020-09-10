import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/strings_constants.dart';
import '../providers/auth.dart';

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
              Provider.of<Auth>(context, listen: false).logout();
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
