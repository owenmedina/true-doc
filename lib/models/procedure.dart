import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';

class Procedure {
  final name;
  final date;
  
  Procedure({
    @required this.name,
    @required this.date,
  });

  factory Procedure.fromMap(Map<String, dynamic> map) {
    return Procedure(name: map['name'], date: map['date'].toDate);
  }

  String getFormattedDate() {
    final dateFormatter = DateFormat.yMMMMd('en_US');
    return dateFormatter.format(date);
  }
}