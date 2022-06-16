// External
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Stream<User?> get onAuthStateChanged;
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<User?> createUserWitEmailAndPassword(
    String email,
    String password,
  );
  User? currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {

  FirebaseAuth get getInstance {
    return FirebaseAuth.instance;
  }

  Future<User?> signInAnonymously() async {
    final authResult = await getInstance.signInAnonymously();
    User? user = authResult.user;
    return user;
  }

  @override
  Stream<User?> get onAuthStateChanged => getInstance.authStateChanges();

  @override
  Future<User?> createUserWitEmailAndPassword(
      String email, String password) async {
    return (await getInstance.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
  }

  @override
  User? currentUser() {
    return getInstance.currentUser;
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final User? user = (await getInstance.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  @override
  Future<void> signOut() {
    return getInstance.signOut();
  }
}
