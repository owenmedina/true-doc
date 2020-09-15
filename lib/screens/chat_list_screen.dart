import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigation_bar.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}