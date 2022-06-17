// External
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Internal
import './auth.dart';
// import '../models/user.dart' as user_model;

class UserBackend {
  // final user_model.User user;

  final _auth = Auth();
  final _databaseRoot = FirebaseFirestore.instance;

  // UserBackend({required this.user});

  void logIn(String email, String password, Map<String, dynamic> data) {
    _auth
        .signInWithEmailAndPassword(email, password)
        .then((_) => data['callback']())
        .timeout(const Duration(seconds: 10))
        .onError((error, __) {
      data['callback']();
      showDialog(
          context: data['context'],
          builder: (thisDialogContext) {
            return AlertDialog(
              title: const Text('Alert',
                  style: TextStyle(
                    fontFamily: 'Abel',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              content: Text(
                error.toString().replaceAll(RegExp(r'\[.*\]\s*'), ''),
                style: const TextStyle(
                  fontFamily: 'Abel',
                  fontSize: 17.0,
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(thisDialogContext);
                    },
                    child: const Text('Ok')),
              ],
            );
          });
      return null;
    });
  }

  void signUp(String email, String password, String username, String telephone,
      Map<String, dynamic> data) {
    _auth
        .createUserWitEmailAndPassword(email, password)
        .then((instance) => setUserInitialData(instance, username, telephone))
        .then((_) => data['callback']())
        .timeout(const Duration(seconds: 10))
        .onError((error, __) {
      data['callback']();
      showDialog(
          context: data['context'],
          builder: (thisDialogContext) {
            return AlertDialog(
              title: const Text('Alert',
                  style: TextStyle(
                    fontFamily: 'Abel',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              content: Text(
                error.toString().replaceAll(RegExp(r'\[.*\]\s*'), ''),
                style: const TextStyle(
                  fontFamily: 'Abel',
                  fontSize: 17.0,
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(thisDialogContext);
                    },
                    child: const Text('Ok')),
              ],
            );
          });
      return null;
    });
    ;
  }

  void setUserInitialData(User? instance, String username, String telephone) {
    _databaseRoot.collection('users').doc(instance?.uid).set({
      'telephone': telephone,
      'username': username,
    });
  }

  void logOut() {
    _auth.signOut();
  }
}
