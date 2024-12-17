import 'package:get/get.dart';
import 'package:tap_coin/models/user_model.dart';
import 'package:tap_coin/screens/home_screen.dart';
import 'package:tap_coin/screens/login_screen.dart';
import 'package:tap_coin/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  AuthController(this._authService) {
    _initUser();
  }

  void _initUser() {
    user.value = _authService.getUserLocally();
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      final result =
          await _authService.signInWithEmailAndPassword(email, password);
      if (result != null) {
        user.value = result;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    try {
      isLoading.value = true;
      final result = await _authService.registerWithEmailAndPassword(
          username, email, password);
      if (result != null) {
        user.value = result;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    user.value = null;
  }
}
