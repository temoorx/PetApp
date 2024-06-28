import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:your_app_test/src/data/common/object_mapper.dart';
import 'package:your_app_test/src/domain/common/result.dart';

sealed class FirebaseRepository {
  Future<Result<UserCredential>> signUpWithFirebase(
      {required String email, required String password});
  Future<Result<UserCredential>> signInWithFirebase(
      {required String email, required String password});
  Future<Result<DocumentSnapshot>> getUserData({required String uid});

}

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final ObjectMapper objectMapper;
  final Logger logger;

  FirebaseRepositoryImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.objectMapper,
    required this.logger,
  });

  @override
  Future<Result<UserCredential>> signUpWithFirebase(
      {required String email, required String password}) async {
    try {
      final UserCredential response =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore.collection('users').doc(response.user?.uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return Result.success(objectMapper.toSignUpWithFirebase(response));
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return Result.failed(objectMapper.toError(e));
    }
  }

  @override
  Future<Result<UserCredential>> signInWithFirebase(
      {required String email, required String password}) async {
    try {
      final UserCredential response =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.success(objectMapper.toSignUpWithFirebase(response));
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return Result.failed(objectMapper.toError(e));
    }
  }

  @override
  Future<Result<DocumentSnapshot>> getUserData({required String uid}) async {
    try {
      final DocumentSnapshot response =
          await firestore.collection('users').doc(uid).get();
      return Result.success(response);
    } on Exception catch (e) {
      logger.e(e);
      return Result.failed(objectMapper.toError(e));
    }
  }
}
