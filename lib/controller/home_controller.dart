import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tap_coin/services/auth_service.dart';
import 'package:tap_coin/services/game_service.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final GameService _gameService = Get.find();
  final AuthService _authService = Get.find();

  late AnimationController animationController;
  late AnimationController scaleAnimationController;
  late Animation<double> scaleAnimation;

  final RxBool showAnimation = false.obs;
  final RxDouble topPosition = 100.0.obs;
  final RxDouble leftPosition = 100.0.obs;
  final RxInt currencyCount = 0.obs;
  final RxInt tapCount = 1000.obs;

  Timer? tapResetTimer;
  Timer? refillTimer;
  Timer? _syncTimer;

  bool get isUpdating => _gameService.isUpdating.value;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _loadUserData();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: scaleAnimationController, curve: Curves.easeInOut),
    );
  }

  void _loadUserData() {
    final user = _authService.getUserLocally();
    if (user != null) {
      currencyCount.value = user.coinCount;
      tapCount.value = user.tapCount;
    }
  }

  void handleTap(TapDownDetails details, Size size) {
    if (isUpdating || tapCount.value <= 0) return;

    HapticFeedback.lightImpact();

    double newTopPosition = details.localPosition.dy - 30;
    double newLeftPosition = details.localPosition.dx - 15;

    // Ensure the animation stays within the container bounds
    newTopPosition = newTopPosition.clamp(0.0, size.height - 60);
    newLeftPosition = newLeftPosition.clamp(0.0, size.width - 30);

    // Update currency count using .value
    currencyCount.value++;
    topPosition.value = newTopPosition;
    leftPosition.value = newLeftPosition;
    showAnimation.value = true;

    if (tapCount.value > 0) {
      tapCount.value--;
    }

    // Update local storage immediately
    _gameService.updateCoinCount(currencyCount.value);
    _gameService.updateTapCount(tapCount.value);

    // Debounce Firestore sync
    _syncTimer?.cancel();
    _syncTimer = Timer(const Duration(milliseconds: 500), () {
      _gameService.syncWithFirestore();
    });

    // Reset timers
    refillTimer?.cancel();
    tapResetTimer?.cancel();
    tapResetTimer = Timer(const Duration(seconds: 1), startRefillTimer);

    // Animations
    animationController.forward(from: 0.0).then((_) {
      showAnimation.value = false;
    });

    scaleAnimationController.forward().then((_) {
      scaleAnimationController.reverse();
    });
  }

  void startRefillTimer() {
    refillTimer = Timer.periodic(const Duration(milliseconds: 333), (timer) {
      if (tapCount.value < 1000) {
        tapCount.value++;
        _gameService.updateTapCount(tapCount.value);

        // Debounce the Firestore sync for refill updates
        _syncTimer?.cancel();
        _syncTimer = Timer(const Duration(milliseconds: 500), () {
          _gameService.syncWithFirestore();
        });
      } else {
        refillTimer?.cancel();
      }
    });
  }

  void signOut() async {
    await _authService.signOut();
  }

  @override
  void onClose() {
    animationController.dispose();
    scaleAnimationController.dispose();
    tapResetTimer?.cancel();
    refillTimer?.cancel();
    _syncTimer?.cancel();
    super.onClose();
  }
}