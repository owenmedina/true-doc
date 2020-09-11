import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './auth.dart';
import '../models/app_user.dart';

class Patient with ChangeNotifier {
  //List<AppUser> 
  void getPhysicians() {
    final currentUserId = Auth().currentUserId;
    FirebaseFirestore.instance.collection('patients').doc(currentUserId).collection('physicians').get().then((data) {
      print('Physicians for user {$currentUserId}: ');
      data.docs.forEach((dataElement) { 
        print(dataElement.id);
      });
    }).catchError((e) {
      print('Caught error in patient.getPhysicians(): $e');
      throw e;
    });
  }
}