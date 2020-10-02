import 'package:flutter/material.dart';

import 'message_bubble.dart';
import 'message_time.dart';
import '../date_divider.dart';
import '../../models/message.dart';
import '../../services/messages.dart';

class MessagesList extends StatelessWidget {
  final conversationId;

  MessagesList(this.conversationId);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder(
          stream: Messages().streamMessages(conversationId),
          builder: (ctx, AsyncSnapshot<List<Message>> messages) {
            if (messages.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (messages.data == null || messages.hasError) {
              return Center(child: Text('Error occurred! Please try again.'));
            } else if (messages.data.isEmpty) {
              return Center(child: Text('No messages yet.'));
            }

            return ListView.builder(
              reverse: true,
              itemCount: messages.data.length,
              itemBuilder: (listViewCtx, i) => Column(
                key: ValueKey(messages.data[i].id),
                crossAxisAlignment: messages.data[i].isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (messages.data[i].fromDifferentDays(
                      messages.data[i],
                      i + 1 >= messages.data.length
                          ? null
                          : messages.data[i + 1]))
                    DateDivider(messages.data[i]),
                  MessageBubble(messages.data[i]),
                  MessageTime(
                    message: messages.data[i],
                    isLast: i == 0,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   final padding = MediaQuery.of(context).padding;
//   final screenHeight =
//       MediaQuery.of(context).size.height - padding.top - padding.bottom;
//   final conversations = Provider.of<List<Conversation>>(context);
//   return ListView.builder(
//     itemCount: conversations.length,
//     itemBuilder: (listViewCtx, i) => ListTile(
//       key: ValueKey(conversations[i].id),
//       leading: CircleAvatar(
//         radius: screenHeight * 0.03,
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             conversations[i].otherName,
//             style: TextStyle(fontSize: screenHeight * 0.025),
//           ),
//           Text(
//             conversations[i].formattedLastMessageDate ?? '',
//             style: TextStyle(fontSize: screenHeight * 0.02),
//           )
//         ],
//       ),
//       subtitle: Text(
//         conversations[i].lastMessage ?? '',
//         style: TextStyle(fontSize: screenHeight * 0.02),
//       ),
//       onTap: () {
//         Navigator.pushNamed(context, MessagesScreen.routeName, arguments: [
//           conversations[i].id,
//           conversations[i].otherName,
//           conversations[i].otherId,
//         ]);
//       },
//     ),
//   );
// }

// ListTile(
//             key: ValueKey(conversations[i].id),
//             leading: CircleAvatar(
//               radius: screenHeight * 0.03,
//             ),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   conversations[i].otherName,
//                   style: TextStyle(fontSize: screenHeight * 0.025),
//                 ),
//                 Text(
//                   conversations[i].formattedLastMessageDate ?? '',
//                   style: TextStyle(fontSize: screenHeight * 0.02),
//                 )
//               ],
//             ),
//             subtitle: Text(
//               conversations[i].lastMessage ?? '',
//               style: TextStyle(fontSize: screenHeight * 0.02),
//             ),
//             onTap: () {
//               Navigator.pushNamed(context, MessagesScreen.routeName,
//                   arguments: [
//                     conversations[i].id,
//                     conversations[i].otherName,
//                     conversations[i].otherId,
//                   ]);
//             },
//           ),
