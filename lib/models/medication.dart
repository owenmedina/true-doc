import 'package:flutter/foundation.dart';

class Medication {
  final String id;
  final String name;
  final String prescribedBy;

  Medication({
    @required this.id,
    @required this.name,
    @required this.prescribedBy,
  });
}

class PatientMedication extends Medication {
  final String patientMedicationId;
  final String medicationId;
  final String dosage;
  final String frequency;

  PatientMedication({
    @required this.patientMedicationId,
    @required this.medicationId,
    @required name,
    @required this.dosage,
    @required this.frequency,
    @required prescribedBy,
    genericName,
  }) : super(id: medicationId, name: name, prescribedBy: prescribedBy,);
}
