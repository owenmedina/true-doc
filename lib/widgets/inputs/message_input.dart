import 'package:flutter/material.dart';

import '../../utilities/constants/numerical_constants.dart';

class MessageInput extends StatefulWidget {
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _textEditingController = TextEditingController();

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
              maxLines: null,
              style: TextStyle(fontSize: screenHeight * 0.024),
              decoration: InputDecoration.collapsed(
                hintText: 'Type here',
                hintStyle: TextStyle(fontSize: screenHeight * 0.02),
              ),
              controller: _textEditingController,
            ),
          ),
        ),
        IconButton(
          icon: Image.asset('assets/illustrations/send-message.png'),
          onPressed: () {},
        ),
      ]),
    );
  }
}
