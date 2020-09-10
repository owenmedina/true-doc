import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './constants/app_colors.dart';
import './providers/auth.dart';
import './screens/error_screen.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './screens/meeting_screen.dart';
import './screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // Initializes Firebase Services (before app is created) for use in the app

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
      ],
      child: MaterialApp(
        title: 'true doc',
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
        home: StreamBuilder(
          // Initialize FlutterFire:
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error initializing Firebase: ${snapshot.error}');
              return ErrorScreen();
              // TODO: Complete error screen (display image 404 Not Found or some error)
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
              // TODO: Complete SplashScreen (I guess logo title is good for now)
            }

            if (snapshot.hasData)
              return HomeScreen(); //MeetingScreen(); // return home screen
            else
              return LoginScreen();
          },
        ),
      ),
    );
  }
}
