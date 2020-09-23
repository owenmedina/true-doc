import 'package:flutter/material.dart';

import '../utilities/constants/app_colors.dart';

class MessagesScreen extends StatelessWidget {
  static const routeName = '/messages';

  PreferredSize buildAppBar(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context).settings.arguments as List<dynamic>;
    String otherId;
    String otherName;
    if (args != null) {
      otherId = args[0];
      otherName = args[1];
    }
    return PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5,
            ),
          ],
        ),
        height: screenHeight * 0.16,
        padding: EdgeInsets.only(
          top: screenHeight * 0.04,
          bottom: screenHeight * 0.005,
          right: screenWidth * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  maxRadius: screenHeight * 0.04,
                ),
                SizedBox(height: screenHeight * 0.010),
                Text(
                  otherName,
                  style: Theme.of(context).primaryTextTheme.headline1.copyWith(
                      fontSize: screenHeight * 0.0225, color: Colors.black),
                ),
              ],
            ),
            // TODO: find a nice icon for three dots and back
            IconButton(icon: Icon(Icons.more_horiz), onPressed: null),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(child: Text('Messages Screen to be completed')),
    );
  }
}
