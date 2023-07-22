import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/core/network/firestore.dart';
import 'package:nuntium/features/auth/data/response/login_response.dart';

abstract class RemoteLoginWithGoogleDataSource {
  Future<LoginResponse> login();
}

class RemoteLoginWithGoogleDataSourceImpl implements RemoteLoginWithGoogleDataSource {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  Future<LoginResponse> login() async {
    final userCredential = await _signInWithGoogle();

    if (userCredential == null) {
      throw 'GoogleSignIn faild';
    }

    final userDoc = await _getUserDoc(userCredential.user!.email!);

    return LoginResponse(
      email: userDoc.get(FirestoreConstants.email),
      name: userDoc.get(FirestoreConstants.name),
      userCredential: userCredential,
    );
  }

  Future<GoogleSignInAccount?> signOut() {
    return _googleSignIn.signOut();
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Get GoogleSignInAuthentication to sign in with Firebase
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential using the GoogleSignInAuthentication
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google Auth Credential
        final UserCredential userCredential = await _auth.signInWithCredential(googleAuthCredential);
        return userCredential;
      }
    } catch (e) {
      log("Google Sign-In failed: $e");
      rethrow;
    }
    return null;
  }

  Future<DocumentSnapshot> _getUserDoc(String userEmail) async {
    return usersCollection.doc(userEmail).get();
  }


}
