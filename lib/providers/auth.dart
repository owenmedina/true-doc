import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/strings_constants.dart';

class Auth with ChangeNotifier {
  String handleFirebaseAuthException(e) {
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

  Future<String> authenticate(
      String email, String password, String firstName, String lastName, bool isLogin) async {
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
          FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set({
            'email': email,
            'firstName': firstName,
            'lastName': lastName,
          });
        } catch (e) {
          print('Error adding new user to Firestore collection users: $e');
        }
        // FirebaseFirestore.instance.collection;
        // instance.collection('users').document(authResult.user.uid).setData({
        //   'username': username,
        //   'email': email,
        //   'image_url': url,
        // });
      }

      if (userCredential.user != null)
        status = StringConstants.success;
      else
        status = StringConstants.undefined;
    } on FirebaseAuthException catch (e) {
      status = handleFirebaseAuthException(e);
    } catch (e) {
      status = StringConstants.undefined;
      print('Unknown error: ${e.toString()}');
    }
    return status;
  }

  Future<void> logout() async {
    print('Attempting to log out');
    await FirebaseAuth.instance.signOut();
    print('Successfully logged out');
  }
}
