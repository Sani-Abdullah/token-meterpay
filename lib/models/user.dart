// External
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String telephone;
  final List<Map<String, dynamic>> transactions;
  final List<Map<String, dynamic>> meters;

  User({required this.uid, required this.email, required this.username, required this.telephone, required this.transactions, required this.meters});

  User.fromFireStore(DocumentSnapshot user)
      : uid = user.id,
        email = user.get('email'),
        username = user.get('username'),
        telephone = user.get('telephone'),
        transactions = user.get('transactions') as List<Map<String, dynamic>>,
        meters = user.get('meters') as List<Map<String, dynamic>>;
}
