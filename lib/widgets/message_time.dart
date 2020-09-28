import 'package:flutter/material.dart';

import '../models/message.dart';
import '../utilities/utility_functions.dart';

class MessageTime extends StatelessWidget {
  final Message message;
  final bool isLast;

  MessageTime({this.message, this.isLast});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Container(
      child: Text(
        message.isRead && isLast && message.isMe
            ? 'Read at ${message.readAt}'
            : message.formattedTime,
        style: TextStyle(fontSize: screenHeight * 0.015),
      ),
      margin: EdgeInsets.only(
        right: message.isMe ? screenWidth * 0.04 : 0,
        left: message.isMe ? 0 : screenWidth * 0.04,
        bottom: screenHeight * 0.01,
      ),
    );
  }
}
