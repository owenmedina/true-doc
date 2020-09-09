import 'package:flutter/material.dart';

import '../constants/strings_constants.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(StringConstants.homeScreenTitle),
      body: Center(
        child: Text('Home screen to be completed'),
      ),
    );
  }
}
