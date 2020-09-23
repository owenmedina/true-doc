import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './messages_screen.dart';
import '../models/conversation.dart';
import '../providers/conversations.dart';
import '../services/auth.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final conversations = Provider.of<List<Conversation>>(context);
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (listViewCtx, i) => ListTile(
        key: ValueKey(conversations[i].id),
        leading: CircleAvatar(
          radius: screenHeight * 0.03,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              conversations[i].other,
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            Text(
              conversations[i].formattedLastMessageDate ?? '',
              style: TextStyle(fontSize: screenHeight * 0.02),
            )
          ],
        ),
        subtitle: Text(
          conversations[i].lastMessage ?? '',
          style: TextStyle(fontSize: screenHeight * 0.02),
        ),
        onTap: () {
          Navigator.pushNamed(context, MessagesScreen.routeName, arguments: [conversations[i].id, conversations[i].other]);
        },
      ),
    );
  }
}
