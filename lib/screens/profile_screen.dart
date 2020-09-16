import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Profile Page to be completed', style: Theme.of(context).textTheme.bodyText1,),
      ),
    );
  }
}
