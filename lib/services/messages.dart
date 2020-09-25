import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class Messages {
  static const List<Message> initialData = [];
  static List<Message> catchError(BuildContext context, Object error) {
    print('Caught error when creating StreamProvider<List<Message>>: $error');
    return null;
  }

  Stream<List<Message>> streamMessages(String conversationId) {
    var ref = FirebaseFirestore.instance
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('date', descending: true);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Message.fromDocument(doc)).toList());
  }

  // Future<void> sendMessage(
  //     String message, String sender, Timestamp date) async {
  //   try {
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userCredential.user.uid)
  //         .set({
  //       'type': 'patient',
  //     });
  //     FirebaseFirestore.instance
  //         .collection('patients')
  //         .doc(userCredential.user.uid)
  //         .set({
  //       'email': email,
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'type': 'patient',
  //     });
  //   } catch (e) {
  //     print('Error adding new user to Firestore collection users: $e');
  //   }
  // }
}
