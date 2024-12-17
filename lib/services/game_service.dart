import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tap_coin/services/shared_prefrence.dart';
import '../controller/auth_controller.dart';

class GameService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storage = Get.find<StorageService>();
  String? get currentUserId => Get.find<AuthController>().user.value?.uid;

  // Track if an update is in progress
  final RxBool isUpdating = false.obs;

  // Batch updates
  int _pendingCoinCount = 0;
  int _pendingTapCount = 0;
  bool _hasChanges = false;

  Future<void> updateCoinCount(int newCount) async {
    if (currentUserId == null) return;

    // Update local storage immediately for responsive UI
    await _storage.saveCoinCount(newCount);
    _pendingCoinCount = newCount;
    _hasChanges = true;
  }

  Future<void> updateTapCount(int newCount) async {
    if (currentUserId == null) return;

    // Update local storage immediately for responsive UI
    await _storage.saveTapCount(newCount);
    _pendingTapCount = newCount;
    _hasChanges = true;
  }

  Future<void> syncWithFirestore() async {
    if (!_hasChanges || currentUserId == null || isUpdating.value) return;

    try {
      isUpdating.value = true;

      await _firestore.collection('users').doc(currentUserId).update({
        'coinCount': _pendingCoinCount,
        'tapCount': _pendingTapCount,
      });

      _hasChanges = false;
    } catch (e) {
      print('Error syncing with Firestore: $e');
      // Optionally handle error (e.g., retry logic or user notification)
    } finally {
      isUpdating.value = false;
    }
  }

  int getCoinCount() => _storage.getCoinCount();
  int getTapCount() => _storage.getTapCount();

  // Helper method to check if updates are in progress
  bool get isUpdateInProgress => isUpdating.value;
}