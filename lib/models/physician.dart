

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
    id,
    firstName,
    lastName,
    this.dob,
    this.gender,
    this.specialties,
    this.patients,
    // qualifications
  }) : super(id: id, firstName: firstName, lastName: lastName, type: UserType.physician);
}
