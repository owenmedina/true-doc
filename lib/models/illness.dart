import 'package:flutter/material.dart';

import '../utilities/constants/string_constants.dart';

class Illness {
  final name;
  DateTime start;
  DateTime end;

  Illness({
    @required this.name,
    @required this.start,
    this.end,
  });

  factory Illness.fromMap(Map<String, dynamic> map) {
    final newIllness = Illness(
      name: map['name'],
      start: map['start'].toDate(),
      end: map.containsKey('end') ? map['end'] : null,
    );

    return newIllness;
  }

  String getDuration() {
    if (end == null) return StringConstants.ongoing;
    else if (start.year == end.year) return '${start.year}';
    return '${start.year}-${end.year}';
  }

  Color getDurationColor() {
    if (end == null) return Colors.green;
    else return Colors.grey;
  }
}
