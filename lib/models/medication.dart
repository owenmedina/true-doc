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

class PatientMedication {
  final String id;
  final String medicationId;
  final String dosage;
  final String frequency;

  PatientMedication({
    @required this.id,
    @required this.medicationId,
    @required this.dosage,
    @required this.frequency,
  });
}
