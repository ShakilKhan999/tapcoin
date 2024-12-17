import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tap_coin/services/shared_prefrence.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storage = Get.find<StorageService>();

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        final userData = await _getUserData(result.user!.uid);
        if (userData != null) {
          await _storage.saveUser(userData);
          return userData;
        }
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<UserModel?> registerWithEmailAndPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        final userModel = UserModel(
          uid: result.user!.uid,
          username: username,
          email: email,
        );

        await _firestore
            .collection('users')
            .doc(userModel.uid)
            .set(userModel.toJson());

        await _storage.saveUser(userModel);
        return userModel;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<UserModel?> _getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: ${e.toString()}');
      return null;
    }
  }

  UserModel? getUserLocally() => _storage.getUser();

  Future<void> signOut() async {
    await _auth.signOut();
    await _storage.clearStorage();
  }
}
