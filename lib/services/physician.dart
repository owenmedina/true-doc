import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/physician.dart' as Model;
import '../models/specialty.dart';

class Physician {
  // TODO: finish method to get physician by id and return it it in patient.dart so that they can
  Model.Physician getPhysicianById(String id) {
    final docRef = FirebaseFirestore.instance.collection('physicians').doc(id);
    docRef.get().then((doc) {
      if (doc.exists) {
        print('Physician data: ${doc.data()}');
        final specialties = (doc.data()['specialties'] as List<dynamic>).map((e) => SpecialtyHelper.stringToSpecialty(e)).toList();
        print('Specialties: $specialties');
        final newPhysician = Model.Physician(
          lastName: doc.data()['lastName'],
          firstName: doc.data()['firstName'],
          specialties: specialties,
        ); // add specialties
        print('New physician: ${newPhysician.lastName}');
        return newPhysician;
      } else {
        // doc.data() is undefined
        print("No such document!");
        return null;
      }
    }).catchError((e) {
      print('Caught error in physician.getPhysicianById(): $e');
      throw e;
    });
  }
}
