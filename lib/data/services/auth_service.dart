import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:oauth2/oauth2.dart';
import '../state_manager/auth/desktop/desktop_auth_manager.dart';

@LazySingleton()
class AuthService {
  final DesktopAuthManager _desktopAuthManager;
  final FirebaseFirestore fireStore;

  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthService(this._desktopAuthManager, this.fireStore, this.firebaseAuth);

  Future<firebase_auth.User?> signInWithCredentials(
    firebase_auth.AuthCredential authCredential,
  ) async {
    firebase_auth.User? user;
    try {
      final firebase_auth.UserCredential userCredential =
          await firebaseAuth.signInWithCredential(authCredential);
      user = userCredential.user;
    } on Exception {
      rethrow;
    }
    return user;
  }

  Future<firebase_auth.User?> signInWithEmailPassword(
      String email, String password) async {
    firebase_auth.User? user;
    try {
      final firebase_auth.UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      // Handle Firebase authentication exceptions
      // (e.g., invalid email/password, user disabled)
      if (e.code == 'user-not-found') {
        throw Exception('Email ou mot de passe incorrect.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Email ou mot de passe incorrect.');
      } else {
        throw Exception(
            e.message ?? 'Une erreur s\'est produite.');
      }
    }
    return user;
  }

  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } on Exception {
      return false;
    }
  }
}
