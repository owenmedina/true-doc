import './app_user.dart';
import './medication.dart';
import './physician.dart';

class Patient extends AppUser {
  DateTime dob;
  double height;
  double weight;
  String primaryPhysicianId;
  List<Physician> physicians; // list of physicians that work with this patient
  List<String> conditions;
  List<PatientMedication> medications;

  Patient({
    id,
    firstName,
    lastName,
    this.dob,
    this.height,
    this.weight,
    this.primaryPhysicianId,
    this.physicians,
    this.conditions,
    this.medications,
  }) : super(id: id, firstName: firstName, lastName: lastName, type: UserType.patient);
}
