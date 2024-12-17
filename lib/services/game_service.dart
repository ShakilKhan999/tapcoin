import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tap_coin/services/shared_prefrence.dart';
import '../controller/auth_controller.dart';

class GameService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storage = Get.find<StorageService>();
  String? get currentUserId => Get.find<AuthController>().user.value?.uid;

  Future<void> updateCoinCount(int newCount) async {
    if (currentUserId == null) return;

    await _storage.saveCoinCount(newCount);
    await _firestore.collection('users').doc(currentUserId).update({
      'coinCount': newCount,
    });
  }

  Future<void> updateTapCount(int newCount) async {
    if (currentUserId == null) return;

    await _storage.saveTapCount(newCount);
    await _firestore.collection('users').doc(currentUserId).update({
      'tapCount': newCount,
    });
  }

  int getCoinCount() => _storage.getCoinCount();
  int getTapCount() => _storage.getTapCount();
}
