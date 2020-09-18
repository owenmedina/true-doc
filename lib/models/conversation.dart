import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import './app_user.dart';

class Conversation {
  String lastMessage;
  DateTime lastMessageDate;
  String senderFirstName;
  String senderLastName;

  Conversation({
    @required this.lastMessage,
    @required this.lastMessageDate,
    @required this.senderFirstName,
    @required this.senderLastName,
  });

  static Conversation fromLastMessageMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Conversation(
      lastMessage: map['message'],
      lastMessageDate: map['date'].toDate(),
      senderFirstName: map['senderFirstName'],
      senderLastName: map['senderLastName'],
    );
  }

  String _convertTimeStamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    
    // if today, only return time HH:MM

    // if not but this year, return MM dd

    // if not and not this year, return MM dd, yyyy
  }
}
