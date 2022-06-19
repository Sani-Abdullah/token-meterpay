// Core
import 'dart:convert';
import 'dart:math';

// External
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meterpay/models/transaction_record.dart';
import 'package:crypto/crypto.dart';

// Internal
import './auth.dart';
import '../models/user.dart' as userM;

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

  // <TBD> all function down

  Future<userM.User> getUser() async {
    return userM.User.fromFireStore(await _databaseRoot
        .collection('users')
        .doc(_auth.currentUser()!.uid)
        .get());
  }

  void addTransaction(TransactionRecord txnRecord) {
    _databaseRoot.collection('users').doc(_auth.currentUser()!.uid).update({
      'transactions': {
        txnRecord.txnReference: {
          'txnReference': txnRecord.txnReference,
          'token': txnRecord.token,
          'receiptID': txnRecord.receiptID,
          'units': txnRecord.units,
          'meterNumber': txnRecord.meterNumber,
          'meterName': txnRecord.meterName,
          'date': txnRecord.date,
          'priceGross': txnRecord.priceGross,
          'priceNet': txnRecord.priceNet,
          'debt': txnRecord.debt,
          'vat': txnRecord.vat,
          'serviceCharge': txnRecord.serviceCharge,
          'freeUnits': txnRecord.freeUnits,
          'paymentType': txnRecord.paymentType,
          'username': txnRecord.username,
          'address': txnRecord.address,
          'meterCategory': txnRecord.meterCategory,
        }
      }
    });
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    final userDoc = await _databaseRoot
            .collection('users')
            .doc(_auth.currentUser()!.uid)
            .get();
        
        return userDoc.get('transactions');
  }

  Future<void> addMeter(String meterNumber, String meterName) async {
    _databaseRoot.collection('users').doc(_auth.currentUser()!.uid).update({
      'meters': FieldValue.arrayUnion([{'meterName': meterName, 'meterNumber': meterNumber}])
    });
  }

  Future<void> removeMeter(dynamic meterObject) async {
     _databaseRoot.collection('users').doc(_auth.currentUser()!.uid).update({
      'meters': FieldValue.arrayRemove([meterObject])
    });
  }

  Future<dynamic> getMeters() async {
    final userDoc = await _databaseRoot
            .collection('users')
            .doc(_auth.currentUser()!.uid)
            .get();
        
        return userDoc.get('meters');
  }
}
