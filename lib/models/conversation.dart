import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../services/auth.dart';

class Conversation {
  String id;
  String lastMessage;
  Timestamp lastMessageDate;
  String formattedLastMessageDate;
  String otherName;
  String otherId;

  Conversation({
    @required this.id,
    @required this.lastMessage,
    @required this.lastMessageDate,
    @required this.otherName,
    @required this.otherId,
  });

  factory Conversation.fromDocument(QueryDocumentSnapshot document) {
    Conversation newConversation = Conversation(
      id: '',
      lastMessage: '',
      lastMessageDate: null,
      otherName: '',
      otherId: '',
    );
    newConversation.id = document.id;
    newConversation.lastMessage = document.data()['messagePreview'];
    newConversation.lastMessageDate = document.data()['dateActive'];
    newConversation.formattedLastMessageDate =
        _convertTimeStamp(newConversation.lastMessageDate);
    newConversation.otherName = document.data()['members'][0] == Auth.currentUserId
        ? document.data()['membersNames'][1]
        : document.data()['membersNames'][0];
    newConversation.otherId = document.data()['members'][0] == Auth.currentUserId
        ? document.data()['members'][1]
        : document.data()['members'][0];
    return newConversation;
  }

  void setFormattedLastMessageDate(Conversation conversation) {
    conversation.formattedLastMessageDate = _convertTimeStamp(conversation.lastMessageDate);
  }

  // Conversation.fromDocumentChange(
  //     DocumentChange docChange, Message lastMessage) {
  //   print('${docChange.doc.id}: ${docChange.doc.data()} \n');
  //   final currentUserId = Auth.currentUserId;
  //   final docData = docChange.doc.data();
  //   final senderFirstName = docData['user1'] != currentUserId
  //       ? docData['user1FirstName']
  //       : docData['user2FirstName'];
  //   final senderLastName = docData['user1'] != currentUserId
  //       ? docData['user1LastName']
  //       : docData['user2LastName'];
  //   print('First Name: $docData');
  //   print('lastMessageDate is null: ${lastMessage.date == null}');
  //   this.id = docChange.doc.id;
  //   this.lastMessage = lastMessage.message;
  //   this.lastMessageDate = lastMessage.date;
  //   this.formattedLastMessageDate = _convertTimeStamp(lastMessage.date);
  //   this.otherFirstName = senderFirstName;
  //   this.otherLastName = senderLastName;
  // }

  // Conversation.fromDocumentChangeWithoutMessage(DocumentChange docChange) {
  //   final docData = docChange.doc.data();
  //   final currentUserId = Auth.currentUserId;
  //   final senderFirstName = docData['user1'] != currentUserId
  //       ? docData['user1FirstName']
  //       : docData['user2FirstName'];
  //   final senderLastName = docData['user1'] != currentUserId
  //       ? docData['user1LastName']
  //       : docData['user2LastName'];

  //   this.id = docChange.doc.id;
  //   this.otherFirstName = senderFirstName;
  //   this.otherLastName = senderLastName;
  // }

  static String _convertTimeStamp(Timestamp timestamp) {
    final messageDateTime = timestamp.toDate();
    final messageDate = DateTime(
        messageDateTime.year, messageDateTime.month, messageDateTime.day);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentYear = now.year;
    // final thisWeek = DateTime(now.year, now.month, now.day + 1);

    // Use different formatter depending on date
    DateFormat dateFormatter;
    // if today, only return time HH:MM
    if (messageDate == today) {
      dateFormatter = DateFormat.jm();
    }
    // if not but this week, weekday abbreviation
    else if (_isPartofCurrentWeek(messageDate)) {
      dateFormatter = DateFormat.E();
    }
    // if not but this year, return MM dd
    else if (messageDateTime.year == currentYear) {
      dateFormatter = DateFormat.MMMd();
    }
    // if not and not this year, return MM dd, yyyy
    else {
      dateFormatter = DateFormat.yMMMMd('en_US');
    }

    return dateFormatter.format(messageDateTime);
  }

  static bool _isPartofCurrentWeek(DateTime date) {
    final now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    // whatever weekday it is today it will subtract that much from today to get Sunday
    final firstDayOfTheWeek = now.subtract(Duration(days: now.weekday));
    return _withinDateRange(
        date,
        firstDayOfTheWeek.subtract(Duration(microseconds: 1)),
        firstDayOfTheWeek.add(Duration(days: 7)));
  }

  static bool _withinDateRange(
      DateTime date, DateTime endOfLastWeek, DateTime endOfWeek) {
    final isBeforeEndOfWeek = date.isBefore(endOfWeek);
    final isAfterEndOfLastWeek = date.isAfter(endOfLastWeek);
    return isBeforeEndOfWeek && isAfterEndOfLastWeek;
  }

  String toString() {
    return '$id $otherName$otherId: $lastMessage at $lastMessageDate ($formattedLastMessageDate)';
  }
}
