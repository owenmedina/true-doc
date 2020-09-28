import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  final message;

  DateDivider(this.message);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message.formatDateForChat(),
            style: TextStyle(color: Colors.grey[400]),
          ),
          Divider(
            color: Colors.grey[400],
            indent: screenWidth * 0.45,
            endIndent: screenWidth * 0.45,
          ),
        ],
      ),
    );
  }
}
