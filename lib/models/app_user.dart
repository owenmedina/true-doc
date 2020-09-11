import 'package:flutter/foundation.dart';

class AppUser {
  final String id;
  String firstName;
  String lastName;
  final UserType type;

  AppUser({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.type,
  });
}

enum UserType { patient, doctor, nurse }
