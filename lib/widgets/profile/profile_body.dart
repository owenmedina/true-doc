import 'package:flutter/material.dart';

import './medical_history_view.dart';
import './medication_view.dart';
import './patient_info_view.dart';
import '../../models/app_user.dart';
import '../../models/patient.dart';

class ProfileBody extends StatelessWidget {
  final controller;
  final tabList;
  Widget _tabPages(Tab tab) {
    switch (tab.text) {
      case 'Basic Info':
        return PatientInfoView(
          Patient(
            id: null,
            firstName: null,
            lastName: null,
          ),
        );
      case 'Medical History':
        return MedicalHistoryView();
      case 'Medication':
        return MedicationView();
    }
  }

  ProfileBody({this.controller, this.tabList});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.08,
        vertical: screenHeight * 0.06,
      ),
      child: TabBarView(
        controller: controller,
        children: [
          PatientInfoView(
            Patient(id: null, firstName: null, lastName: null),
          ),
          MedicalHistoryView(),
          MedicationView(),
        ],
      ),
    );
  }
}
