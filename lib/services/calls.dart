import 'package:cloud_firestore/cloud_firestore.dart';

class Calls {
  Future<void> createCall(String physicianId, String patientId) async {
    try {
      final response = await FirebaseFirestore.instance.collection('calls').add({
        'physician': physicianId,
        'patient': patientId,
        'start': DateTime.now().toIso8601String(),
      });
      return response;
    } catch (e) {
      print('Caught error in Calls.createCall(): $e');
      return null;
    }
  }

  Future<void> endCall(String callId) {
    try {
      FirebaseFirestore.instance.collection('calls').doc(callId).set({
        'end': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Caught error in Calls.endCall(): $e');
    }
  }
}
