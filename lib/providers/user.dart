import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import '../models/patient.dart';
import '../models/physician.dart';
import '../services/auth.dart';

class User with ChangeNotifier {
  AppUser _user;

  AppUser get user {
    return _user;
  }

  Future<void> _fetchAndSetUser() async {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(Auth.currentUserId);
    try {
      final userDoc = await userRef.get();
      if (userDoc.exists) {
        if (userDoc.data()['type'] == 'patient') {

          _user = Patient(id: Auth.currentUserId, firstName: null, lastName: null);
        }
        // final specialties = (doc.data()['specialties'] as List<dynamic>)
        //     .map((e) => SpecialtyUtility.stringToSpecialty(e))
        //     .toList();
        // final newPhysician = Physician(
        //   id: doc.id,
        //   lastName: doc.data()['lastName'],
        //   firstName: doc.data()['firstName'],
        //   specialties: specialties,
        // );
        // return newPhysician;

        // setup user as patient or physician and fill necessary data
      } else {
        // doc.data() is undefined
        print("No such document!");
        return null;
      }
    } catch (e) {
      print('Caught error in user.fetchAndSetUser(): $e');
      throw e;
    }
  }
}