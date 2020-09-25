import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilityFunctions {
  static Future<void> showAdaptiveDialog(BuildContext context, String title, String content) async {
    if (Platform.isAndroid) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(content),
        ),
      );
    } else if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
        ),
      );
    }
  }
}
