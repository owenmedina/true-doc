import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigation_bar.dart';

class ChatListScreen extends StatelessWidget {
  static const routeName = '/messages';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}