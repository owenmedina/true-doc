import 'package:flutter/foundation.dart';

import './app_user.dart';
import './gender.dart';
import './patient.dart';
import './specialty.dart';

class Physician extends AppUser {
  DateTime dob;
  Gender gender;
  List<Specialty> specialties;
  List<Patient> patients; // list of patients that work with this physician

  Physician({
    @required id,
    @required firstName,
    @required lastName,
    this.dob,
    this.gender,
    @required this.specialties,
    this.patients,
    // qualifications
  }) : super(id: id, firstName: firstName, lastName: lastName, type: UserType.physician);
}
