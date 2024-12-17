import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_coin/common/app_constanats.dart';
import '../models/user_model.dart';

class StorageService extends GetxService {
  late final SharedPreferences _prefs;
  final RxBool isInitialized = false.obs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    isInitialized.value = true;
    return this;
  }

  // User Related Methods
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(AppConstants.keyUid, user.uid);
    await _prefs.setString(AppConstants.keyUsername, user.username);
    await _prefs.setString(AppConstants.keyEmail, user.email);
    await _prefs.setInt(AppConstants.keyCoinCount, user.coinCount);
    await _prefs.setInt(AppConstants.keyTapCount, user.tapCount);
    await _prefs.setString(AppConstants.keyRank, user.rank);
  }

  UserModel? getUser() {
    final uid = _prefs.getString(AppConstants.keyUid);
    if (uid == null) return null;

    return UserModel(
      uid: uid,
      username: _prefs.getString(AppConstants.keyUsername) ?? '',
      email: _prefs.getString(AppConstants.keyEmail) ?? '',
      coinCount: _prefs.getInt(AppConstants.keyCoinCount) ?? 0,
      tapCount: _prefs.getInt(AppConstants.keyTapCount) ??
          AppConstants.defaultTapCount,
      rank: _prefs.getString(AppConstants.keyRank) ?? AppConstants.defaultRank,
    );
  }

  // Game Related Methods
  Future<void> saveCoinCount(int count) async {
    await _prefs.setInt(AppConstants.keyCoinCount, count);
  }

  Future<void> saveTapCount(int count) async {
    await _prefs.setInt(AppConstants.keyTapCount, count);
  }

  int getCoinCount() => _prefs.getInt(AppConstants.keyCoinCount) ?? 0;
  int getTapCount() =>
      _prefs.getInt(AppConstants.keyTapCount) ?? AppConstants.defaultTapCount;

  // Clear Storage
  Future<void> clearStorage() async {
    await _prefs.clear();
  }
}
