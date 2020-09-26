import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UtilityFunctions {
  static Future<void> showAdaptiveDialog(
      BuildContext context, String title, String content) async {
    if (Platform.isAndroid) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(content),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      );
    } else if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  static String formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final dateFormatter = DateFormat.jm();
    final formattedString = dateFormatter.format(dateTime);
    return formattedString;
  }
}
