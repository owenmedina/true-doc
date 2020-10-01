import 'package:flutter/foundation.dart';

class Medication {
  final String id;
  final String scientificName;
  final String genericName;

  Medication({
    @required this.id,
    @required this.scientificName,
    this.genericName,
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
    @required scientificName,
    @required this.dosage,
    @required this.frequency,
  }) : super(id: medicationId, scientificName: scientificName);
}
