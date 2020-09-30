import 'package:flutter/material.dart';

import '../../models/patient.dart';
import '../../utilities/constants/string_constants.dart';

class PatientInfoView extends StatelessWidget {
  Patient patient;

  PatientInfoView(this.patient);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TextInfoTile(title: 'Primary Physician', content: 'Dr. First LastName'),
        SizedBox(height: screenHeight * 0.02),
        TextInfoTile(title: 'Blood Type', content: 'A+'),
        SizedBox(height: screenHeight * 0.04),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 5 / 2,
          children: [
            IconInfoTile(
              label: 'August 00, 2020',
              imageName: 'birthday',
              alignment: MainAxisAlignment.start,
            ),
            IconInfoTile(
              label: 'Male',
              imageName: 'gender',
              alignment: MainAxisAlignment.end,
            ),
            IconInfoTile(
              label: '158 cm',
              imageName: 'height',
              alignment: MainAxisAlignment.start,
            ),
            IconInfoTile(
              label: '51 kg',
              imageName: 'weight',
              alignment: MainAxisAlignment.end,
            ),
            // IconInfoTile(label: 'Dr. FirstName LastName', imageName: 'physician'),
            // IconInfoTile(label: 'A+', imageName: 'blood-type'),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: screenHeight * 0.02,
          ),
          child: Divider(),
        ),
        IconInfoTile(
            label: '000-000-0000',
            imageName: 'phone',
            alignment: MainAxisAlignment.start),
        SizedBox(height: screenHeight * 0.02),
        IconInfoTile(
            label: 'namename@email.com',
            imageName: 'email',
            alignment: MainAxisAlignment.start),
      ],
    );
    // return GridView.count(
    //   mainAxisSpacing: 0,
    //   crossAxisCount: 2,
    //   children: [
    //     Row(
    //       children: [
    //         Image.asset(
    //           'assets/illustrations/profile/basic/birthday.png',
    //           height: screenHeight * 0.05,
    //         ),
    //         Text('Birthday'),
    //       ],
    //     ),
    //   ],
    // );
  }
}

class IconInfoTile extends StatelessWidget {
  final imageName;
  final label;
  final alignment;

  IconInfoTile({
    @required this.label,
    @required this.imageName,
    @required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/illustrations/profile/basic/$imageName.png',
            height: screenHeight * 0.05,
          ),
          SizedBox(width: screenWidth * 0.02),
          Container(
            height: screenHeight * 0.05,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: screenHeight * 0.02,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextInfoTile extends StatelessWidget {
  final title;
  final content;

  TextInfoTile({@required this.title, this.content});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Row(
      children: [
        Text(
          '$title: ',
          style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.02,
              fontFamily: 'Kumbh-Sans'),
        ),
        Text(
          content ?? StringConstants.noData,
          style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
              color: Colors.black,
              fontSize: screenHeight * 0.02,
              fontFamily: 'Kumbh-Sans'),
        ),
      ],
    );
  }
}
