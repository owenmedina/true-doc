import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../services/messages.dart';

class MessageInput extends StatefulWidget {
  final conversationId;

  MessageInput(this.conversationId);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _textEditingController = TextEditingController();
  var _enteredMessage = '';

  void sendMessage(BuildContext context) {
    final message = _textEditingController.text;
    final timestamp = Timestamp.fromDate(DateTime.now());
    Messages().sendMessage(
      context: context,
      conversationId: widget.conversationId,
      message: message,
      timestamp: timestamp,
      senderId: Auth.currentUserId,
    );
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      child: Row(children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              left: screenWidth * 0.01,
              top: screenHeight * 0.0125,
              bottom: screenHeight * 0.0125,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[100],
            ),
            padding: EdgeInsets.only(
                top: screenHeight * 0.010,
                left: screenWidth * 0.060,
                right: screenWidth * 0.050,
                bottom: screenHeight * 0.010),
            child: TextField(
              controller: _textEditingController,
              onChanged: (newMessage) {
                setState(() {
                  _enteredMessage = newMessage;
                });
              },
              style: TextStyle(fontSize: screenHeight * 0.0225),
              decoration: InputDecoration.collapsed(
                hintText: 'Type here',
                hintStyle: TextStyle(fontSize: screenHeight * 0.02),
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
            ),
          ),
        ),
        IconButton(
          icon: Image.asset('assets/illustrations/send-message.png'),
          onPressed:
              _enteredMessage.trim().isEmpty ? null : () => sendMessage(context),
        ),
      ]),
    );
  }
}
