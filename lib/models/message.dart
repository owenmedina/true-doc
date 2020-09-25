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

  bool fromDifferentDays(Message currentMessage, Message messageBelow) {
    if (messageBelow == null) return true;
    final currentMessageDateTime = currentMessage.date.toDate();
    final currentMessageDate = DateTime(
        currentMessageDateTime.year, currentMessageDateTime.month, currentMessageDateTime.day);

    final messageBelowDateTime = messageBelow.date.toDate();
    final messageBelowDate = DateTime(messageBelowDateTime.year, messageBelowDateTime.month, messageBelowDateTime.day);

    return currentMessageDate != messageBelowDate;
  }

  String formatDateForChat() {
    final messageDateTime = date.toDate();
    final messageDate = DateTime(
        messageDateTime.year, messageDateTime.month, messageDateTime.day);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentYear = now.year;

    // Use different formatter depending on date
    DateFormat dateFormatter;
    // if today, only return time HH:MM
    if (messageDate == today) {
      return 'Today';
    }
    // if not but this week, weekday abbreviation
    else if (_isPartofCurrentWeek(messageDate)) {
      dateFormatter = DateFormat.EEEE();
    }
    // if not but this year, return month and day
    else if (messageDateTime.year == currentYear) {
      dateFormatter = DateFormat.MMMMd();
    }
    // if not and not this year, return month day and year
    else {
      dateFormatter = DateFormat.yMMMMd('en_US');
    }

    return dateFormatter.format(messageDateTime);
  }

  bool _isPartofCurrentWeek(DateTime date) {
    final now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    // whatever weekday it is today it will subtract that much from today to get Sunday
    final firstDayOfTheWeek = now.subtract(Duration(days: now.weekday));
    return _withinDateRange(
        date,
        firstDayOfTheWeek.subtract(Duration(microseconds: 1)),
        firstDayOfTheWeek.add(Duration(days: 7)));
  }

  bool _withinDateRange(
      DateTime date, DateTime endOfLastWeek, DateTime endOfWeek) {
    final isBeforeEndOfWeek = date.isBefore(endOfWeek);
    final isAfterEndOfLastWeek = date.isAfter(endOfLastWeek);
    return isBeforeEndOfWeek && isAfterEndOfLastWeek;
  }
}
