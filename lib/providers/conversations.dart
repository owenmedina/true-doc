import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart' show StreamGroup;

import '../models/conversation.dart';
import '../services/auth.dart';

class Conversations with ChangeNotifier {
  List<Conversation> _conversations = [];

  List<Conversation> get conversations {
    return [..._conversations];
  }

  Future<void> fetchAndSetConversations() async {
    final currentUserId = Auth.currentUserId;
    final conversationsCollection =
        FirebaseFirestore.instance.collection('conversations');

    // To create an OR query, must combine two where queries
    try {
      final firstQuery = conversationsCollection
          .where('user1', isEqualTo: currentUserId)
          .snapshots()
          .listen((convSnapshot) {
        final convs = convSnapshot.docs;
        _updateConversations(convs);
      });
    } catch (e) {
      print(
          'Caught error in first query of conversations.fetchAndSetConversations(): $e');
    }

    try {
      final secondQuery = conversationsCollection
          .where('user2', isEqualTo: currentUserId)
          .snapshots()
          .listen((convSnapshot) {
        final convs = convSnapshot.docs;
        _updateConversations(convs);
      });
    } catch (e) {
      print(
          'Caught error in second query of conversations.fetchAndSetConversations(): $e');
    }

    // conversationsStreams.add(firstQuery);
    // conversationsStreams.add(secondQuery);
    // // Merge streams into one stream
    // Stream<QuerySnapshot> results = StreamGroup.merge(conversationsStreams);
    // var i = 1; // test
    // await for (QuerySnapshot convSnapshot in results) {
    //   print('Iteration ${i++} of ${results.length}');
    //   convSnapshot.docs.forEach((conv) {
    //     print('Conv data: ${conv.data()}');
    //   });
    // }
  }

  Future<Map<String, dynamic>> _getLastMessage(
      QueryDocumentSnapshot conv) async {
    try {
      // Use document snapshot to get the reference so you're able to get the messages subcollection
      // Order by date and limit to 1 to get latest message
      final messageSnapshot = await conv.reference
          .collection('messages')
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      
      final messageDoc =
          messageSnapshot.docs[0]; //messageQuery.docs[0].data();
      print('Last message of ${messageDoc.id}: ${messageDoc.data()}');
      return messageDoc.data();
    } catch (e) {
      print('Caught error in conversations._getLastMessage(): $e');
      throw e;
    }
  }

  Future<void> _updateConversations(
    List<QueryDocumentSnapshot> newConvsSnapshotList) async {
    List<Conversation> conversationsList = [];
    print('List of new conversation data:'); // test
    for (QueryDocumentSnapshot newConvSnapshot in newConvsSnapshotList) {
      print('${newConvSnapshot.id}: ${newConvSnapshot.data()} \n');
      final messageMap = await _getLastMessage(newConvSnapshot);
      conversationsList.add(Conversation.fromLastMessageMap(messageMap));
    }
    _conversations = conversationsList;
    notifyListeners();
  }
}
