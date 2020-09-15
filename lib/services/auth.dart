import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utilities/constants/strings_constants.dart';

class Auth {
  static String _handleFirebaseAuthException(e) {
    var status;
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        status = StringConstants.invalidEmail;
        print('Error in AuthDart._authenticate: invalid email');
        break;
      case 'ERROR_WRONG_PASSWORD':
        status = StringConstants.wrongPassword;
        print('Error in AuthDart._authenticate: wrong password');
        break;
      case 'ERROR_USER_NOT_FOUND':
        status = StringConstants.userNotFound;
        print('Error in AuthDart._authenticate: user not found');
        break;
      case 'ERROR_USER_DISABLED':
        status = StringConstants.userDisabled;
        print('Error in AuthDart._authenticate: user disabled');
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        status = StringConstants.tooManyRequests;
        print('Error in AuthDart._authenticate: too many requests');
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        status = StringConstants.operationNotAllowed;
        print('Error in AuthDart._authenticate: operation not allowed');
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        status = StringConstants.emailAlreadyExists;
        print('Error in AuthDart._authenticate: email already in use');
        break;
      default:
        status = StringConstants.undefined;
        print(
            'Error in AuthDart._authenticate: uncategorized FirebaseAuthException');
    }
    return status;
  }

  static Future<String> authenticate(String email, String password, String firstName,
      String lastName, bool isLogin) async {
    var status;
    try {
      UserCredential userCredential;
      if (isLogin) {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        try {
          FirebaseFirestore.instance
              .collection('patients')
              .doc(userCredential.user.uid)
              .set({
            'email': email,
            'firstName': firstName,
            'lastName': lastName,
            'type': 'patient',
          });
        } catch (e) {
          print('Error adding new user to Firestore collection users: $e');
        }
      }

      if (userCredential.user != null)
        status = StringConstants.success;
      else
        status = StringConstants.undefined;
    } on FirebaseAuthException catch (e) {
      status = _handleFirebaseAuthException(e);
      throw e;
    } catch (e) {
      status = StringConstants.undefined;
      print('Unknown error: ${e.toString()}');
      throw e;
    }
    return status;
  }

  static Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Caught error in auth.logout(): $e');
      throw e;
    }
  }

  static String get currentUserId {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser.uid;
    } else
      return null;
  }
}
