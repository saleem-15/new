import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterResponse {
  UserCredential userCredential;
  DocumentReference userDoc;

  RegisterResponse({
    required this.userCredential,
    required this.userDoc,
  });
}
