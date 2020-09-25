import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../services/auth.dart';

class Message {
  String id;
  String message;
  Timestamp date;
  String formattedTime;
  String senderId;

  bool get isMe {
    return senderId == Auth.currentUserId;
  }

  Message({
    @required this.id,
    @required this.message,
    @required this.date,
    @required this.senderId,
  }) {
    this.formattedTime = _timestampToFormattedString(date);
  }

  Message.fromDocument(QueryDocumentSnapshot doc) {
    final data = doc.data();
    this.id = doc.id;
    this.message = data['message'];
    this.date = data['date'];
    this.formattedTime = _timestampToFormattedString(date);
    this.senderId = data['sender'];
  }

  String toString() {
    return 'Message: $id $message $date $senderId';
  }

  String _timestampToFormattedString(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final dateFormatter = DateFormat.jm();
    final formattedString = dateFormatter.format(dateTime);
    return formattedString;
  }

  Map<String, dynamic> toMap(Message message) {
    return {
      'date': message.date,
      'message': message.message,
      'sender': message.senderId,
    };
  }
}
