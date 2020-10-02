import 'package:flutter/material.dart';

import '../widgets/curve_painter.dart';
import '../widgets/inputs/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          Container(
            child: CustomPaint(
              painter: CurvePainter(),
              size: screenSize,
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.10,
            left: screenSize.width * 0.10,
            child: Image.asset(
              'assets/illustrations/login/doc-nurse-4.png',
              height: screenSize.height * 0.3,
            ),
          ),
          Positioned(
            top: screenSize.height * 0.20,
            child: Container(
              width: screenSize.width,
              child: Text(
                'true doc',
                style: Theme.of(context).primaryTextTheme.headline1.copyWith(
                      fontSize: screenSize.height * 0.07,
                      fontFamily: 'Kumbh-Sans',
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: screenSize.height,
            width: screenSize.width,
            padding: EdgeInsets.all(screenSize.width * 0.05),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginForm(),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
