import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';

import 'entities/entities.dart';

class FirebaseUserRepository implements UserRepository {
  // firebase auth service
  final FirebaseAuth _firebaseAuth;

  // dữ liệu chi tiết profile user trong Firestore.
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> user() => _firebaseAuth.authStateChanges().asyncMap(
        (firebaseUser) async {
      print("FirebaseUser in repo: $firebaseUser");
      if (firebaseUser == null) return null; // chưa login

      try {
        final userSnapshot = await usersCollection.doc(firebaseUser.uid).get();
        if (!userSnapshot.exists) {
          // chưa có document → tạo user tạm bằng FirebaseAuth
          return MyUser(
            userId: firebaseUser.uid,
            email: firebaseUser.email ?? 'unknown',
            name: firebaseUser.displayName ?? 'unknown',
            hasActiveCart: false,
          );
        }
        final userEntity = MyUserEntity.fromDocument(userSnapshot.data()!);
        return MyUser.fromEntity(userEntity);
      } catch (e) {
        // ❌ đừng trả MyUser.empty nữa, coi như null → bắt buộc login lại
        return null;
      }
    },
  );

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      // 1️⃣ Tạo user Firebase Auth
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw Exception('User creation failed');
      }

      // 2️⃣ Lưu thông tin chi tiết user vào Firestore
      final userEntity = MyUserEntity(
        userId: firebaseUser.uid,
        email: myUser.email,
        name: myUser.name,
        hasActiveCart: false,
      );

      await usersCollection.doc(firebaseUser.uid).set(userEntity.toDocument());

      return MyUser.fromEntity(userEntity);
    } catch (e) {
      throw Exception('Error during sign up: $e');
    }
  }

  @override
  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }

  @override
  @override
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      final userEntity = myUser.toEntity();
      final userDoc = usersCollection.doc(userEntity.userId);
      await userDoc.set(userEntity.toDocument());
    } catch (e) {
      rethrow;
    }
  }
}
