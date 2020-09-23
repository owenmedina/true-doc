import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart' show StreamGroup;

import '../models/conversation.dart';
import '../models/message.dart';
import '../services/auth.dart';

class Conversations with ChangeNotifier {
  // final currentUserId = Auth.currentUserId;
  // Map<String, dynamic> _conversations = {};
  // Map<String, dynamic> _messages = {};
  // List<Conversation> _conversationsList = [];
  // List<String> _conversationsIds = [];
  // List<Conversation> get conversationsList {
  //   return [..._conversationsList];
  // }

  // void fetchAndSetConversations() {
  //   // To create an OR query, must combine two where queries
  //   final List<Conversation> updatedConversationsList = [];
  //   try {
  //     FirebaseFirestore.instance
  //         .collection('conversations')
  //         .where('members', arrayContains: Auth.currentUserId)
  //         .orderBy('dateActive', descending: true)
  //         .snapshots().listen((event) {
  //           for(final document in event.docs) {
  //             updatedConversationsList.add(Conversation.fromDocument(document));
  //           }
  //         });
  //     _conversationsList = updatedConversationsList;
  //     print('fetched and set conversations');
  //   } catch (e) {
  //     print(
  //         'Caught error in conversations.fetchAndSetConversations(): $e');
  //   }
  // }

  Stream<List<Conversation>> streamConversations() {
    var ref = FirebaseFirestore.instance
          .collection('conversations')
          .where('members', arrayContains: Auth.currentUserId)
          .orderBy('dateActive', descending: true);

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Conversation.fromDocument(doc)).toList());
    
  }

  // void _setMessages(DocumentSnapshot conv) {
  //   try {
  //     // Use document snapshot to get the reference so you're able to get the messages subcollection
  //     List<Message> messagesList = [];
  //      conv.reference.collection('messages').snapshots().listen((event) {
  //       print('Event size: ${event.size}');
  //       print('Messages for conversation#${conv.id}');
  //       for (QueryDocumentSnapshot doc in event.docs) {
  //         print('Message#${doc.id}: ${doc.data()}');
  //         final newMessage = Message.fromDocument(doc);
  //         print('newMessage: $newMessage');
  //         messagesList.add(newMessage);
  //         print('messagesList: $messagesList');
  //       }
  //       print(
  //           'Length of messagesList for conv#${conv.id}: ${messagesList.length}');

  //       messagesList.sort((m1, m2) => m2.date.compareTo(m1.date));

  //       //print('Last message of Conversation ${conv.id}: ${messagesList.last}');
  //       _messages[conv.id] = messagesList;
  //       notifyListeners();
  //     });

  //     // .orderBy('date', descending: true)
  //     // .limit(1)
  //     // .get();

  //     //final messageDoc = messageSnapshot.docs[0]; //messageQuery.docs[0].data();
  //   } catch (e) {
  //     print('Caught error in conversations._getMessages(): $e');
  //     throw e;
  //   }
  // }

  // void _updateConversationEntry(DocumentChange docChange) {
  //   _setMessages(docChange.doc);
  //   Conversation newConversation;
  //   if (_messages[docChange.doc.id] != null && _messages[docChange.doc.id].isNotEmpty) {
  //     newConversation = Conversation.fromDocumentChange(
  //         docChange,
  //         _messages[docChange.doc.id].last);

      
  //   } else {
  //     newConversation = Conversation.fromDocumentChangeWithoutMessage(docChange);
  //   }
  //   _conversationsIds.add(docChange.doc.id);
  //     _conversations[docChange.doc.id] = newConversation;
  //     _conversationsList = _conversations.values.toList().cast<Conversation>();
  //     _conversationsList
  //         .sort((c1, c2) => c2.lastMessageDate.compareTo(c1.lastMessageDate));
  // }

  // Future<void> _applyConversationsChanges(
  //     List<DocumentChange> docChangesList) async {
  //   List<Conversation> conversationsList = [];
  //   print('List of new conversation data:'); // test
  //   for (DocumentChange docChange in docChangesList) {
  //     switch (docChange.type) {
  //       case DocumentChangeType.added:
  //         // new conversation
  //         _updateConversationEntry(docChange);
  //         notifyListeners();
  //         break;
  //       case DocumentChangeType.modified:
  //         // modified conversation
  //         _updateConversationEntry(docChange);
  //         notifyListeners();
  //         break;
  //       case DocumentChangeType.removed:
  //         // removed conversation
  //         _conversations.remove(docChange.doc.id);
  //         notifyListeners();
  //         break;
  //     }

  //     print('Value: \n $_conversationsList');
  //   }
  // }
}
