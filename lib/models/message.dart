import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {
  String id;
  String message;
  Timestamp date;
  String senderId;

  Message({
    @required this.id,
    @required this.message,
    @required this.date,
    @required this.senderId,
  });

  Message.fromDocument(QueryDocumentSnapshot doc) {
    final data = doc.data();
    this.id = doc.id;
    this.message = data['message'];
    this.date = data['date'];
    this.senderId = data['sender'];
  }

  String toString() {
    return 'Message: $id $message $date $senderId';
  }
}