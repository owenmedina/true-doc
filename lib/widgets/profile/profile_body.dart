import 'package:flutter/material.dart';

import './medical_history_view.dart';
import './medication_view.dart';
import './patient_info_view.dart';
import '../../models/app_user.dart';
import '../../models/medication.dart';
import '../../models/patient.dart';

class ProfileBody extends StatelessWidget {
  final controller;
  final tabList;
  // Widget _tabPages(Tab tab) {
  //   switch (tab.text) {
  //     case 'Basic Info':
  //       return PatientInfoView(
  //         Patient(
  //           id: null,
  //           firstName: null,
  //           lastName: null,
  //         ),
  //       );
  //     case 'Medical History':
  //       return MedicalHistoryView();
  //     case 'Medication':
  //       return MedicationView();
  //   }
  // }

  ProfileBody({this.controller, this.tabList});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    final medication = [
      PatientMedication(
        patientMedicationId: null,
        dosage: '10 mg',
        frequency: 'Every 3rd Wednesday',
        medicationId: null,
        name: 'Amlodipine',
        prescribedBy: 'Dr. Stephen Strange'
      ),
      PatientMedication(
        patientMedicationId: null,
        dosage: '20 mg',
        frequency: 'Every Morning',
        medicationId: null,
        name: 'Lisinopril',
        prescribedBy: 'Dr. Stephen Strange'
      ),
      PatientMedication(
        patientMedicationId: null,
        dosage: '90 mcg',
        frequency: 'Every 22nd',
        medicationId: null,
        name: 'Albuterol',
        prescribedBy: 'Dr. Thor Odinson'
      ),
      PatientMedication(
        patientMedicationId: null,
        dosage: '300 mg',
        frequency: 'Twice a Morning',
        medicationId: null,
        name: 'Gabapentin',
        prescribedBy: 'Dr. Tony Stark'
      ),
      PatientMedication(
        patientMedicationId: null,
        dosage: '40 mg',
        frequency: 'Every Morning',
        medicationId: null,
        name: 'Omeprazole',
        prescribedBy: 'Dr. Tony Stark'
      ),
    ];
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.08,
      ),
      child: TabBarView(
        controller: controller,
        children: [
          PatientInfoView(
            Patient(id: null, firstName: null, lastName: null),
          ),
          MedicalHistoryView(),
          MedicationView(medication),
        ],
      ),
    );
  }
}
