import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/patient.dart';
import '../services/auth.dart';

class Patients with ChangeNotifier {
  Patient _currentPatient;

  Patient get currentPatient {
    if (_currentPatient == null) {

    }
  }

//   Future<Patient> getPatientById(String id) async {
//     final docRef = FirebaseFirestore.instance.collection('patients').doc(id);
//     try {
//       final doc = await docRef.get();
//       if (doc.exists) {
//         final physicians = (doc.data()['specialties'] as List<dynamic>)
//             .map((e) => SpecialtyUtility.stringToSpecialty(e))
//             .toList();
//         final newPhysician = Physician(
//           id: doc.id,
//           lastName: doc.data()['lastName'],
//           firstName: doc.data()['firstName'],
//           specialties: specialties,
//         );
//         return newPhysician;
//       } else {
//         // doc.data() is undefined
//         print("No such document!");
//         return null;
//       }
//     } catch (e) {
//       print('Caught error in database.getPhysicianById(): $e');
//       throw e;
//     }
//   }

//   Future<void> fetchCurrentPatient() async {
//     final current = await getPatientById(Auth.currentUserId);
//     _currentPatient = current;
//   }
}