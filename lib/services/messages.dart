import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';
import '../utilities/utility_functions.dart';
import '../utilities/constants/string_constants.dart';

class Messages {
  static const List<Message> initialData = [];
  static List<Message> catchError(BuildContext context, Object error) {
    print('Caught error when creating StreamProvider<List<Message>>: $error');
    return null;
  }

  Stream<List<Message>> streamMessages(String conversationId) {
    final firestore = FirebaseFirestore.instance;
    var ref = firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('date', descending: true);

    // ref.get().then((value) {
    //   value.docs.forEach((element) {
    //     print('data: ${element.data()}');
    //   });
    // });
    final stream = ref.snapshots().map((list) => list.docs.map((doc) {
          var message = Message.fromDocument(doc);
          if (!message.isMe && !message.isRead) {
            message.isRead =
                true; // may be unnecessary if update on document calls snapshots() again anyways
            firestore
                .collection('conversations')
                .doc(conversationId)
                .collection('messages')
                .doc(doc.id)
                .update({
              'isRead': true,
              'readAt': Timestamp.fromDate(DateTime.now()),
            });
          }
          print('${list.size}: ${message.toString()}');
          return message;
        }).toList());

    print(stream == null);
    return stream;
  }

  Future<void> sendMessage({
    @required BuildContext context,
    @required String conversationId,
    @required String message,
    @required Timestamp timestamp,
    @required String senderId,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .add({
        'message': message,
        'date': timestamp,
        'sender': senderId,
        'isRead': false,
      });

      await firestore.collection('conversations').doc(conversationId).update({
        'messagePreview': message,
        'dateActive': timestamp,
      });
    } catch (e) {
      print('Error adding new message to conversation $conversationId: $e');
      UtilityFunctions.showAdaptiveDialog(
        context,
        StringConstants.genericErrorTitle,
        StringConstants.errorSendingMessage,
      );
    }
  }
}
