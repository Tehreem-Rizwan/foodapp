import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Register user with email, password, and name
  Future<User?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      if (user != null) {
        // Store user information (uid, email, and name) in Firestore
        await _firestore.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'name': name, // Store the username in Firestore
        });
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign in user with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      if (user != null) {
        // Merge existing user data and ensure the name is stored
        await _firestore.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          // You can merge here if the name field already exists in Firestore
        }, SetOptions(merge: true));
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
