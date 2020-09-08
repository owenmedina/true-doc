import 'package:flutter/material.dart';

import './constants/app_colors.dart';
import './screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe',
      theme: ThemeData(
        primarySwatch: AppColors.materialDarkBlue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Kumbh-Sans',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        primaryTextTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.w400,
          ),
          subtitle1: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
          ),
          bodyText1: TextStyle(fontFamily: 'Roboto'),
        ).apply(
          bodyColor: AppColors.darkBlue,
          displayColor: AppColors.darkBlue,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.darkBlue,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
