import 'package:flutter/material.dart';

import '../../models/medication.dart';
import '../../utilities/constants/app_colors.dart';
import '../../utilities/constants/numerical_constants.dart';
import '../../utilities/constants/string_constants.dart';

class MedicationView extends StatelessWidget {
  final List<PatientMedication> medication;

  MedicationView(this.medication);

  void _onMedicationTap(BuildContext context, PatientMedication pMedication) {
    showDialog(
      context: context,
      builder: (ctx) => PatientMedicationCard(pMedication),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
      ),
      child: ListView.builder(
        itemBuilder: (ctx, i) => Card(
          color: i.isEven ? AppColors.faintBlue : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  NumericalConstants.medicationCardRadius)),
          margin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01,
          ),
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.04,
                horizontal: screenWidth * 0.05,
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       medication[i].name,
              //       style:
              //           Theme.of(context).primaryTextTheme.bodyText2.copyWith(
              //                 fontSize: screenHeight * 0.025,
              //                 color: Colors.black,
              //               ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Text(medication[i].dosage),
              //         Text(medication[i].frequency),
              //       ],
              //     )
              //   ],
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        medication[i].name,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2
                            .copyWith(
                              fontSize: screenHeight * 0.025,
                              color: Colors.black,
                            ),
                      ),
                      Text(medication[i].dosage),
                    ],
                  ),
                  Text(medication[i].frequency)
                ],
              ),
            ),
            onTap: () {
              _onMedicationTap(context, medication[i]);
            },
          ),
        ),
        itemCount: medication.length,
      ),
    );
  }
}

class PatientMedicationCard extends StatelessWidget {
  final PatientMedication patientMedication;

  PatientMedicationCard(this.patientMedication);

  List<Widget> _getTableSpacer(double screenHeight) {
    return [
      SizedBox(height: screenHeight * 0.02),
      SizedBox(height: screenHeight * 0.02),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.26,
      ),
      color: AppColors.mediumBlue,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.05,
        ),
        child: Column(
          children: [
            PatientMedicationCardTitle(patientMedication.name),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    PatientMedicationProperty(StringConstants.drugName),
                    PatientMedicationValue(patientMedication.name),
                  ],
                ),
                TableRow(children: _getTableSpacer(screenHeight)),
                TableRow(children: _getTableSpacer(screenHeight)),
                TableRow(
                  children: [
                    PatientMedicationProperty(StringConstants.dosage),
                    PatientMedicationValue(patientMedication.dosage),
                  ],
                ),
                TableRow(children: _getTableSpacer(screenHeight)),
                TableRow(
                  children: [
                    PatientMedicationProperty(StringConstants.frequency),
                    PatientMedicationValue(patientMedication.frequency),
                  ],
                ),
                TableRow(children: _getTableSpacer(screenHeight)),
                TableRow(
                  children: [
                    PatientMedicationProperty(StringConstants.prescribedBy),
                    PatientMedicationValue(patientMedication.prescribedBy),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PatientMedicationCardTitle extends StatelessWidget {
  const PatientMedicationCardTitle(
    this.title, {
    Key key,
  }) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).primaryTextTheme.headline5.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class PatientMedicationValue extends StatelessWidget {
  const PatientMedicationValue(
    this.value, {
    Key key,
  }) : super(key: key);

  final value;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return TableCell(
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black,
          fontSize: screenHeight * 0.025,
        ),
      ),
    );
  }
}

class PatientMedicationProperty extends StatelessWidget {
  const PatientMedicationProperty(
    this.propertyName, {
    Key key,
  }) : super(key: key);

  final propertyName;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return TableCell(
      child: Text(
        '$propertyName:',
        style: TextStyle(
          fontSize: screenHeight * 0.025,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
