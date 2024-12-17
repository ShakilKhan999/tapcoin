// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tap_coin/screens/home_screen.dart';
import 'package:tap_coin/screens/login_screen.dart';
import 'package:tap_coin/services/shared_prefrence.dart';
import 'package:tap_coin/services/auth_service.dart';
import 'package:tap_coin/services/game_service.dart';
import 'package:tap_coin/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.put(StorageService()).init();
  Get.put(AuthService());
  Get.put(GameService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        title: 'Tap Coin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.blue,
        ),
        initialBinding: BindingsBuilder(() {
          Get.put(AuthController(Get.find()));
        }),
        home: const InitialView(), // New widget to handle initial routing
      ),
    );
  }
}

// New widget to handle initial routing
class InitialView extends StatelessWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(builder: (controller) {
      return controller.user.value != null
          ? const HomeView()
          : const LoginView();
    });
  }
}
