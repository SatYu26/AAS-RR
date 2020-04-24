import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
  Future getCurrentUser();
  Future<String> getCurrentUID();
  Future updateUserName(String name, FirebaseUser currentUser);
  Future sendPasswordResetEmail(String email);
  Future singInAnonymously();
  Future convertUserWithEmail(String email, String password, String name);
  Future convertWithGoogle();
  Future<String> signInWithGoogle();
}




class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map(
            (FirebaseUser user) => user?.uid,
      );

  Future<String> getCurrentUID() async {
    FirebaseUser user = (await _firebaseAuth.currentUser());
    return user.uid;
  }



  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Create Anonymous User
  Future singInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  Future convertUserWithEmail(String email, String password,
      String name) async {
    final currentUser = await _firebaseAuth.currentUser();

    final credential = EmailAuthProvider.getCredential(
        email: email, password: password);
    await currentUser.linkWithCredential(credential);
    await updateUserName(name, currentUser);
  }

  Future convertWithGoogle() async {
    final currentUser = await _firebaseAuth.currentUser();
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    await currentUser.linkWithCredential(credential);
    await updateUserName(_googleSignIn.currentUser.displayName, currentUser);
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }


  Future<String> signInWithEmailAndPassword(String email,
      String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password))
        .user;
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email,
      String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password))
        .user;
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = (await _firebaseAuth.currentUser());
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }
}