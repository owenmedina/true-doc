import 'package:flutter/material.dart';

import '../../models/medication.dart';
import '../../utilities/constants/app_colors.dart';
import '../../utilities/constants/numerical_constants.dart';

class MedicationView extends StatelessWidget {
  List<PatientMedication> medication;

  MedicationView(this.medication);

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(NumericalConstants.medicationCardRadius)),
          margin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.04,
              horizontal: screenWidth * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      medication[i].scientificName,
                      style: Theme.of(context).primaryTextTheme.bodyText2.copyWith(
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
        ),
        itemCount: medication.length,
      ),
    );
  }
}
