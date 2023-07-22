import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/core/network/firestore.dart';
import 'package:nuntium/features/auth/data/request/register_request.dart';

import '../response/register_response.dart';

abstract class RemoteRegisterDataSource {
  Future<RegisterResponse> register(RegisterRequest registerRequest);
}

class RemoteRegisterDataSourceImpl implements RemoteRegisterDataSource {
  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: registerRequest.email,
      password: registerRequest.password,
    );

    final userDoc = await _createUserDoc(registerRequest);

    return RegisterResponse(
      userCredential: userCredential,
      userDoc: userDoc,
    );
  }

  Future<DocumentReference> _createUserDoc(RegisterRequest registerRequest) async {
    final userDoc = usersCollection.doc(registerRequest.email);

    await userDoc.set({
      FirestoreConstants.name: registerRequest.name,
      FirestoreConstants.email: registerRequest.email,
    });

    return userDoc;
  }
}
