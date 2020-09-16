import 'package:flutter/material.dart';

import '../screens/call_screen.dart';
import '../screens/chat_list_screen.dart';
import '../screens/profile_screen.dart';
import '../utilities/constants/numerical_constants.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var _currentIndex = 0;
  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/');
        break;
      case 1: 
        Navigator.of(context).pushReplacementNamed(CallScreen.routeName);
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(ChatListScreen.routeName);
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
        break;
      default:
        break;
    }
  }

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
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onTapHandler,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/illustrations/home.png',
              height: screenHeight * 0.04,
            ),
            activeIcon: Image.asset(
              'assets/illustrations/active-home.png',
              height: screenHeight * 0.04,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/illustrations/appointment.png',
              height: screenHeight * 0.04,
            ),
            activeIcon: Image.asset(
              'assets/illustrations/active-appointment.png',
              height: screenHeight * 0.04,
            ),
            title: Text('Appointments'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/illustrations/messages.png',
              height: screenHeight * 0.04,
            ),
            activeIcon: Image.asset(
              'assets/illustrations/active-messages.png',
              height: screenHeight * 0.04,
            ),
            title: Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/illustrations/profile.png',
              height: screenHeight * 0.04,
            ),
            activeIcon: Image.asset(
              'assets/illustrations/active-profile.png',
              height: screenHeight * 0.04,
            ),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
