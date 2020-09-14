import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './auth.dart';
import './physician.dart' as PhysicianService;
import '../models/physician.dart' as Physician;
import '../models/specialty.dart';

class Patient {
  //List<AppUser> 
  List<Physician.Physician> getPhysicians() {
    final currentUserId = Auth().currentUserId;
    List<Physician.Physician> physicians = [];
    FirebaseFirestore.instance.collection('patients').doc(currentUserId).collection('physicians').get().then((data) {
      print('Physicians for user {$currentUserId}: ');
      data.docs.forEach((dataElement) { 
        print(dataElement.id);
        final newPhysician = PhysicianService.Physician().getPhysicianById(dataElement.id);
        print('New physician in getPhysicians: ${newPhysician.lastName}');
        physicians.add(newPhysician);
        print('current physician contents: $physicians');
      });
      return physicians;
    }).catchError((e) {
      print('Caught error in patient.getPhysicians(): $e');
      throw e;
    });
    return null;
  }
}