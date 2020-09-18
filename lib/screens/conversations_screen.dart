import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/conversations.dart';
import '../utilities/constants/string_constants.dart';

class ConversationsScreen extends StatefulWidget {
  static const routeName = '/conversations';

  static AppBar buildAppBar(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return AppBar(
      title: Text(
        StringConstants.conversationsScreenTitle,
        style: Theme.of(context).primaryTextTheme.headline2.copyWith(
              fontSize: screenHeight * 0.05,
            ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
    );
  }

  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  var _isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      Provider.of<Conversations>(context, listen: false)
          .fetchAndSetConversations();
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Consumer<Conversations>(
      builder: (ctx, conv, child) => ListView.builder(
        itemCount: conv.conversations.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: CircleAvatar(
            radius: screenHeight * 0.03,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                conv.conversations[i].senderFirstName,
                style: TextStyle(fontSize: screenHeight * 0.025),
              ),
              Text(
                conv.conversations[i].lastMessageDate.toString(),
                style: TextStyle(fontSize: screenHeight * 0.02),
              )
            ],
          ),
          subtitle: Text(
            conv.conversations[i].lastMessage,
            style: TextStyle(fontSize: screenHeight * 0.02),
          ),
        ),
      ),
    );
  }
}
