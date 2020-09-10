import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class CustomAppBar extends AppBar {
  final String titleText;

  CustomAppBar(this.titleText);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(titleText),
      actions: [
        IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
          Provider.of<Auth>(context, listen: false).logout();
        }),
      ],
    );
  }
}