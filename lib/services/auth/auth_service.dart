import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 🔹 Sign in with Google
  Future<UserCredential?> loginWithGoogle() async {
    try {
      await _googleSignIn.signOut(); // Ensure user selection prompt
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print('Google Sign-In Error: $e');
      }
      return null;
    }
  }

  // 🔹 Sign out from Google
  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.disconnect(); 
      await _firebaseAuth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Google Sign-Out Error: $e');
      }
      throw Exception(e);
    }
  }

  // 🔹 Get current user
  User? getCurrentUser() => _firebaseAuth.currentUser;

  // 🔹 Sign in with Email & Password
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_getAuthErrorMessage(e.code));
    }
  }

  // 🔹 Sign up with Email & Password & Send Email Verification
  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.sendEmailVerification();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getAuthErrorMessage(e.code));
    }
  }

  // 🔹 Send Password Reset Email

  // 🔹 Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Sign-Out Error: $e');
      }
      throw Exception(e);
    }
  }

  // 🔹 Helper method for error messages
  String _getAuthErrorMessage(String errorCode) {
    const errorMessages = {
      'user-not-found': 'No user found with this email.',
      'wrong-password': 'Incorrect password. Try again.',
      'email-already-in-use': 'Email is already registered.',
      'invalid-email': 'Invalid email format.',
      'weak-password': 'Password should be at least 6 characters.',
    };
    return errorMessages[errorCode] ?? 'Authentication failed. Please try again.';
  }
}
