import 'package:flutter/material.dart';

import '../utilities/constants/numerical_constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(NumericalConstants.roundedNavBarRadius),
        topLeft: Radius.circular(NumericalConstants.roundedNavBarRadius),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/illustrations/home.png',
              height: screenHeight * 0.04,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/illustrations/appointment.png',
              height: screenHeight * 0.04,
            ),
            title: Text('Appointments'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/illustrations/messages.png',
              height: screenHeight * 0.04,
            ),
            title: Text('Messages'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   title: Text('Account'),
          // ),
        ],
      ),
    );
  }
}
