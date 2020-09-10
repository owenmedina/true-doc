import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CurvePainter extends CustomPainter {
  @override

  /// Paints the curved shape
  void paint(Canvas canvas, Size size) {
    paintTopWave(canvas, size);
    paintBottomWave(canvas, size);
  }

  void paintTopWave(Canvas canvas, Size size) {
    // canvas: the board size: size of the board
    // Draw the first wave
    var paint = Paint(); // the brush
    paint.color = AppColors.darkBlue;
    paint.style = PaintingStyle.fill;

    var path = Path(); // the drawing
    path.moveTo(0, size.height * 0.10); // Move to point A
    path.quadraticBezierTo(
        size.width * 0.20,
        size.height * 0.20,
        size.width * 0.5,
        size.height *
            0.14); // Curve to C using B (where B is defined by the first two coordinates)
    path.quadraticBezierTo(
        size.width * 0.67,
        size.height * 0.10,
        size.width * 0.81,
        size.height *
            0.18); // Curve to E using D (where D is defined by the first two coordinates)
    path.quadraticBezierTo(
        size.width * 0.89,
        size.height * 0.22,
        size.width,
        size.height *
            0.22); // Curve to G using F (where F is defined by the first two coordinates)
    path.lineTo(size.width, 0); // Create a line to top-right corner
    path.lineTo(0, 0); // Create a line to top-left corner (closes shape)

    canvas.drawPath(path, paint);

    // Draw second wave
    paint.color = AppColors.mediumBlue; // change paint color
    path = Path(); // reset path
    path.moveTo(0, size.height * 0.025); // Move to point A
    path.quadraticBezierTo(
        size.width * 0.30,
        size.height * 0.15,
        size.width * 0.60,
        size.height *
            0.08); // Curve to C using B (where B is defined by the first two coordinates)
    path.quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.06,
        size.width * 0.87,
        size.height *
            0.14); // Curve to E using D (where D is defined by the first two coordinates)
    path.quadraticBezierTo(
        size.width * 0.93,
        size.height * 0.18,
        size.width,
        size.height *
            0.19); // Curve to G using F (where F is defined by the first two coordinates)
    path.lineTo(size.width, 0); // Create a line to top-right corner
    path.lineTo(0, 0); // Create a line to top-left corner (closes shape)

    canvas.drawPath(path, paint);

    // Draw third wave
    paint.color = AppColors.lightBlue; // change paint color
    path = Path(); // reset path
    path.moveTo(size.width * 0.53, 0); // Move to point A
    path.quadraticBezierTo(
        size.width * 0.60,
        size.height * 0.06,
        size.width * 0.78,
        size.height *
            0.06); // Curve to C using B (where B is defined by the first two coordinates)
    path.quadraticBezierTo(
        size.width * 0.94,
        size.height * 0.05,
        size.width,
        size.height *
            0.12); // Curve to G using F (where F is defined by the first two coordinates)
    path.lineTo(size.width, 0); // Create a line to top-right corner
    path.lineTo(0, 0); // Create a line to top-left corner (closes shape)

    canvas.drawPath(path, paint);
  }

  void paintBottomWave(Canvas canvas, Size size) {
    // Draw first wave
    var paint = Paint(); // the brush
    paint.color = AppColors.darkBlue;
    paint.style = PaintingStyle.fill;

    var path = Path(); // the drawing
    path.moveTo(0, size.height * 0.82); // Move to point A
    path.quadraticBezierTo(
      size.width * 0.12,
      size.height * 0.78,
      size.width * 0.35,
      size.height * 0.88,
    ); // Curve to C using B (where B is defined by the first two coordinates)
    path.quadraticBezierTo(
      size.width * 0.51,
      size.height * 0.94,
      size.width * 0.67,
      size.height * 0.91,
    ); // Curve to E using D (where D is defined by the first two coordinates)
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.87,
      size.width,
      size.height * 0.91,
    ); // Curve to G using F (where F is defined by the first two coordinates)
    path.lineTo(size.width, size.height); // Create a line to top-right corner
    path.lineTo(
        0, size.height); // Create a line to top-left corner (closes shape)

    canvas.drawPath(path, paint);

    // Draw second wave
    paint.color = AppColors.mediumBlue; // change paint color
    path = Path(); // reset path
    path.moveTo(0, size.height * 0.90); // Move to point A
    path.quadraticBezierTo(
      size.width * 0.07,
      size.height * 0.87,
      size.width * 0.19,
      size.height * 0.93,
    ); // Curve to C using B (where B is defined by the first two coordinates)
    path.quadraticBezierTo(
      size.width * 0.27,
      size.height * 0.97,
      size.width * 0.38,
      size.height * 0.95,
    ); // Curve to E using D (where D is defined by the first two coordinates)
    path.quadraticBezierTo(
      size.width * 0.56,
      size.height * 0.91,
      size.width * 0.722,
      size.height,
    ); // Curve to G using F (where F is defined by the first two coordinates)
    path.lineTo(size.width, size.height); // Create a line to top-right corner
    path.lineTo(
        0, size.height); // Create a line to top-left corner (closes shape)

    canvas.drawPath(path, paint);

    // Draw third wave
    paint.color = AppColors.lightBlue; // change paint color
    path = Path(); // reset path
    path.moveTo(0, size.height * 0.97); // Move to point A
    path.quadraticBezierTo(
      size.width * 0.07,
      size.height * 0.93,
      size.width * 0.12,
      size.height * 0.96,
    ); // Curve to C using B (where B is defined by the first two coordinates)
    path.quadraticBezierTo(
      size.width * 0.18,
      size.height * 0.99,
      size.width * 0.24,
      size.height * 0.98,
    ); // Curve to E using D (where D is defined by the first two coordinates)
    path.quadraticBezierTo(
      size.width * 0.32,
      size.height * 0.96,
      size.width * 0.38,
      size.height,
    ); // Curve to G using F (where F is defined by the first two coordinates)
    path.lineTo(size.width, size.height); // Create a line to top-right corner
    path.lineTo(
        0, size.height); // Create a line to top-left corner (closes shape)

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
