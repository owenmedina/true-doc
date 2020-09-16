import 'package:flutter/material.dart';

import './call_screen.dart';
import './chat_list_screen.dart';
import './home_screen.dart';
import './profile_screen.dart';
import '../services/auth.dart';
import '../utilities/constants/numerical_constants.dart';
import '../utilities/constants/string_constants.dart';
import '../widgets/app_bars/home_app_bar.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _pages;
  var _selectedIndex = 0;

  void _onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
        'appBar': AppBar(title: Text(StringConstants.homeScreenTitle)),
      },
      {
        'page': CallScreen(),
        'appBar': AppBar(
          centerTitle: true,
          title: Text(StringConstants.callScreenTitle),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Auth.logout();
              },
            ),
          ],
        ),
      },
      {
        'page': ChatListScreen(),
        'appBar': null,
      },
      {
        'page': ProfileScreen(),
        'appBar': null,
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Scaffold(
      appBar: _pages[_selectedIndex]['appBar'],
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: _buildNavigationBar(screenHeight),
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildNavigationBar(double screenHeight) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(NumericalConstants.roundedNavBarRadius),
        topLeft: Radius.circular(NumericalConstants.roundedNavBarRadius),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
