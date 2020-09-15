import 'package:cloud_firestore/cloud_firestore.dart';

class Calls {
  static Future<String> createCall(String physicianId, String patientId) async {
    try {
      final response = await FirebaseFirestore.instance.collection('calls').add({
        'physicianId': physicianId,
        'patientId': patientId,
        'start': DateTime.now().toIso8601String(),
      });
      return response.id;
    } catch (e) {
      print('Caught error in Calls.createCall(): $e');
      throw e;
    }
  }

  static void endCall(String callId) {
    try {
      FirebaseFirestore.instance.collection('calls').doc(callId).update({
        'end': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Caught error in Calls.endCall(): $e');
      throw e;
    }
  }
}
