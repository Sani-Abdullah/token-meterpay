// External
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String telephone;

  const User({required this.uid, required this.email, required this.username, required this.telephone});

  User.fromFireStore(DocumentSnapshot user)
      : uid = user.id,
        email = user.get('email'),
        username = user.get('username'),
        telephone = user.get('telephone');
}
