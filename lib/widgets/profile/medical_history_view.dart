import 'package:flutter/material.dart';

import '../../models/illness.dart';
import '../../models/procedure.dart';
import '../../utilities/constants/string_constants.dart';

class MedicalHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.06,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MedicalHistorySection(SectionType.Illnesses),
          MedicalHistorySection(SectionType.Procedures),
        ],
      ),
    );
  }
}

class MedicalHistorySection extends StatelessWidget {
  final sectionType;

  MedicalHistorySection(this.sectionType);
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            sectionType == SectionType.Illnesses
                ? StringConstants.illnessesSectionTitle
                : StringConstants.proceduresSectionTitle,
            style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Expanded(child: SectionGrid(sectionType)),
        ],
      ),
    );
  }
}

class SectionGrid extends StatelessWidget {
  final sectionType;
  final illnesses = [
    Illness(
      name: 'Vitamin D Deficiency',
      start: DateTime(2020),
    ),
    Illness(
      name: 'Kidney Infection',
      start: DateTime(2015),
      end: DateTime(2016),
    ),
    Illness(
      name: 'Kidney Infection',
      start: DateTime(2008),
      end: DateTime(2008),
    ),
    Illness(
      name: 'Kidney Infection',
      start: DateTime(2008),
      end: DateTime(2008),
    ),
    Illness(
      name: 'Kidney Infection',
      start: DateTime(2008),
      end: DateTime(2008),
    ),
    Illness(
      name: 'Kidney Infection',
      start: DateTime(2008),
      end: DateTime(2008),
    ),
  ];

  final procedures = [
    Procedure(
      name: 'Colonoscopy',
      date: DateTime(2020, 4, 1),
    ),
    Procedure(
      name: 'Kidney Transplant',
      date: DateTime(2017, 1, 2),
    ),
    Procedure(
      name: 'Colonoscopy',
      date: DateTime(2020, 4, 1),
    ),
    Procedure(
      name: 'Kidney Transplant',
      date: DateTime(2017, 1, 2),
    ),
    Procedure(
      name: 'Colonoscopy',
      date: DateTime(2020, 4, 1),
    ),
    Procedure(
      name: 'Kidney Transplant',
      date: DateTime(2017, 1, 2),
    ),
  ];

  SectionGrid(
    this.sectionType, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return ListView.separated(
      itemBuilder: (ctx, i) {
        switch (sectionType) {
          case SectionType.Illnesses:
            return IllnessTile(illnesses[i]);
            break;
          case SectionType.Procedures:
            return ProcedureTile(procedures[i]);
            break;
          default:
            return SectionTile(
              item: StringConstants.noData,
              date: StringConstants.noDate,
            );
        }
      },
      itemCount: sectionType == SectionType.Illnesses
          ? illnesses.length
          : procedures.length,
      separatorBuilder: (ctx, i) => SizedBox(height: screenHeight * 0.02),
    );
  }
}

class IllnessTile extends StatelessWidget {
  final illness;

  IllnessTile(this.illness);

  @override
  Widget build(BuildContext context) {
    return SectionTile(
      item: illness.name,
      date: illness.getDuration(),
      dateColor: illness.getDurationColor(),
    );
  }
}

class ProcedureTile extends StatelessWidget {
  final procedure;

  ProcedureTile(this.procedure);

  @override
  Widget build(BuildContext context) {
    return SectionTile(
      item: procedure.name,
      date: procedure.getFormattedDate(),
    );
  }
}

class SectionTile extends StatelessWidget {
  const SectionTile({
    Key key,
    @required this.item,
    @required this.date,
    this.dateColor = Colors.black,
  }) : super(key: key);

  final item;
  final date;
  final dateColor;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item,
          style: TextStyle(
            fontSize: screenHeight * 0.025,
          ),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: screenHeight * 0.025,
            color: dateColor,
          ),
        ),
      ],
    );
  }
}

enum SectionType {
  Illnesses,
  Procedures,
}
