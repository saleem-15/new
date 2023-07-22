import 'package:firebase_auth/firebase_auth.dart';

class LoginResponse {
  UserCredential userCredential;
  String name;
  String email;

  LoginResponse({
    required this.userCredential,
    required this.name,
    required this.email,
  });
}
