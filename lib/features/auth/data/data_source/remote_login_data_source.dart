import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/core/network/firestore.dart';
import 'package:nuntium/features/auth/data/request/login_request.dart';
import 'package:nuntium/features/auth/data/response/login_response.dart';

abstract class RemoteLoginDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
}

class RemoteLoginDataSourceImpl implements RemoteLoginDataSource {
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginRequest.email!,
      password: loginRequest.password!,
    );

    final userDoc = await _getUserDoc(loginRequest.email!);

    return LoginResponse(
      email: userDoc.get(FirestoreConstants.email),
      name: userDoc.get(FirestoreConstants.name),
      userCredential: userCredential,
    );
  }

  Future<DocumentSnapshot> _getUserDoc(String userEmail) async {
    return usersCollection.doc(userEmail).get();
  }
}
