import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/physician.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../utilities/specialty_utility.dart';

class Physicians with ChangeNotifier {
  List<Physician> _physicians = [];
  List<String> _physicianIds = [];

  List<Physician> get physicians {
    return [..._physicians];
  }

  // Future<void> fetchAndSetPhysicians() async {
  //   final physiciansList = await Database.getPhysicians();
  //   _physicians = physiciansList;
  //   dataList.forEach((element) {
  //     final fileExists = File(element['image'])
  //         .exists()
  //         .then((value) => print('dataList element\'s file exists: $value)'));
  //   });
  //   _items = dataList
  //       .map((e) => Place(
  //             id: e['id'],
  //             title: e['title'],
  //             image: File(
  //               e['image'],
  //             ),
  //             location: PlaceLocation(
  //               latitude: e['loc_lat'],
  //               longitude: e['loc_lng'],
  //               address: e['address'],
  //             ),
  //           ))
  //       .toList();
  //   notifyListeners();
  // }

  Future<Physician> getPhysicianById(String id) async {
    final docRef = FirebaseFirestore.instance.collection('physicians').doc(id);
    try {
      final doc = await docRef.get();
      if (doc.exists) {
        final specialties = (doc.data()['specialties'] as List<dynamic>)
            .map((e) => SpecialtyUtility.stringToSpecialty(e))
            .toList();
        final newPhysician = Physician(
          lastName: doc.data()['lastName'],
          firstName: doc.data()['firstName'],
          specialties: specialties,
        );
        return newPhysician;
      } else {
        // doc.data() is undefined
        print("No such document!");
        return null;
      }
    } catch (e) {
      print('Caught error in database.getPhysicianById(): $e');
      throw e;
    }
  }

  Future<void> fetchAndSetPhysicians() async {
    final currentUserId = Auth.currentUserId;
    List<Physician> physiciansList = [];
    final physiciansCollection = FirebaseFirestore.instance
        .collection('patients')
        .doc(currentUserId)
        .collection('physicians');
    try {
      final physiciansData = await physiciansCollection.get();
      for (QueryDocumentSnapshot data in physiciansData.docs) {
        final newPhysician = await getPhysicianById(data.id);
        physiciansList.add(newPhysician);
      }
      _physicians = physiciansList;
      // physiciansData.docs.forEach((physiciansDatum) async {
      //   final newPhysician = await getPhysicianById(physiciansDatum.id);
      //   physiciansList.add(newPhysician);
      // });
      // physiciansList = physiciansData.docs.map((pId) async {
      //   await getPhysicianById(pId.id).then((value) => value);
      // });
      // _physicians = physiciansList;
      notifyListeners();
      print('physicians contents after getPhysicians: $physiciansList');
    } catch (e) {
      print('Caught error in physicians.fetchAndSetPhysicians(): $e');
      throw e;
    }
  }

}