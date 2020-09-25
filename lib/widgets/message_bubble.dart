import 'package:flutter/material.dart';

import '../utilities/constants/app_colors.dart';

class MessageBubble extends StatelessWidget {
  String id;
  String message;
  String sender;
  bool isMe;

  MessageBubble(message) {
    this.id = message.id;
    this.message = message.message;
    this.sender = message.senderId;
    this.isMe = message.isMe;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Container(
      constraints: BoxConstraints(maxWidth: screenWidth * 0.6),
      child: Text(
        message,
        style: TextStyle(
          fontSize: screenHeight * 0.02,
        ),
      ),
      decoration: BoxDecoration(
        color: isMe ? AppColors.mediumBlue : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: isMe ? Radius.circular(20) : Radius.zero,
          bottomRight: isMe ? Radius.zero : Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.0175,
        horizontal: screenWidth * 0.05,
      ),
      margin: EdgeInsets.only(
        top: screenHeight * 0.015,
        bottom: screenHeight * 0.015,
        left: isMe ? 0 : screenWidth * 0.04,
        right: isMe ? screenWidth * 0.04 : 0,
      ),
    );
  }
}
