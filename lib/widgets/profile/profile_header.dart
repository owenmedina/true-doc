import 'package:flutter/material.dart';

import '../../utilities/constants/app_colors.dart';
import '../../utilities/constants/numerical_constants.dart';

class ProfileHeader extends StatelessWidget {
  final controller;
  final tabList;

  ProfileHeader({
    this.controller,
    this.tabList,
  });

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(NumericalConstants.standardBorderRadius),
          bottomRight: Radius.circular(NumericalConstants.standardBorderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 3,
          )
        ],
        color: AppColors.mediumBlue,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: screenHeight * 0.065,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: screenHeight * 0.025),
          Text(
            'Name',
            style: TextStyle(
              fontSize: screenHeight * 0.03,
              fontWeight: FontWeight.bold,
            ),
          ),
          TabBar(
            controller: controller,
            indicatorColor: Colors.transparent, // underline indicator is hidden
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: tabList,
            labelStyle: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.025,
                ),
            unselectedLabelStyle:
                Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                      fontSize: screenHeight * 0.02,
                    ),
          ),
        ],
      ),
    );
  }
}
