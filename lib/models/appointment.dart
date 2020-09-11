import 'package:flutter/foundation.dart';

import './app_user.dart';

class Appointment {
  final String id;
  final AppUser physician;
  final AppUser patient;
  final DateTime start;
  final DateTime end;

  Appointment({
    @required this.id,
    @required this.physician,
    @required this.patient,
    this.start,
    this.end,
  });
}
