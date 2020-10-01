import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../utilities/constants/app_colors.dart';
import '../utilities/constants/string_constants.dart';
import '../widgets/profile/profile_body.dart';
import '../widgets/profile/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  static AppBar buildAppBar(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return AppBar(
      backgroundColor: AppColors.mediumBlue,
      actions: [
        IconButton(
          icon: Image.asset(
            'assets/illustrations/profile/settings.png',
            height: screenHeight * 0.05,
          ),
          onPressed: null,
        ),
      ],
      elevation: 0,
    );
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  var _isInitialized = false;
  TabController tabController;
  var _tabList = List<Tab>();
  List<Tab> get tabList {
    return [..._tabList];
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final padding = MediaQuery.of(context).padding;
      final screenHeight =
          MediaQuery.of(context).size.height - padding.top - padding.bottom;
      _tabList.addAll([
        Tab(
          icon: Image.asset(
            'assets/illustrations/profile/basic/person.png',
            height: screenHeight * 0.04,
          ),
        ),
        Tab(
          icon: Image.asset(
            'assets/illustrations/profile/history/medical-history.png',
            height: screenHeight * 0.04,
          ),
        ),
        Tab(
          icon: Image.asset(
            'assets/illustrations/profile/medication/medical-bag.png',
            height: screenHeight * 0.04,
          ),
        ),
      ]);
      // _tabList.addAll(StringConstants.profileTabTitles.map(
      //   (title) => Tab(
      //     text: title,
      //   ),
      // ),);
      tabController = TabController(
        length: _tabList.length,
        vsync: this,
        initialIndex: 2, // testing purposes (remove property when done testing)
      );
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight = MediaQuery.of(context).size.height -
        padding.top -
        padding.bottom -
        kToolbarHeight -
        kBottomNavigationBarHeight;
    return Column(
      children: [
        Container(
          height: screenHeight * 0.3,
          child: ProfileHeader(
            controller: tabController,
            tabList: tabList,
          ),
        ),
        Container(
          height: screenHeight * 0.65,
          child: ProfileBody(
            controller: tabController,
            tabList: tabList,
          ),
        ),
      ],
    );
  }
}
