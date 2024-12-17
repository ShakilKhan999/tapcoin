import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tap_coin/common/bottom_navigation.dart';
import 'package:tap_coin/common/responsive_layout.dart';
import 'package:tap_coin/controller/app_coontroller.dart';
import 'package:tap_coin/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final appcontroller = Get.put(AppController());

    return ResponsiveLayout(
      mobileView: _buildMobileView(controller),
      desktopView: _buildDesktopView(controller),
    );
  }

  Widget _buildMobileView(HomeController controller) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildDailyTasks(),
                  _buildCurrencyDisplay(controller),
                  _buildCharacterDisplay(constraints, controller),
                  _buildBoostSection(controller),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildDesktopView(HomeController controller) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  Column(
                    children: [
                      _buildHeader(),
                      _buildDailyTasks(),
                    ],
                  ),
                  Column(
                    children: [
                      _buildCurrencyDisplay(controller),
                      _buildCharacterDisplay(constraints, controller),
                      _buildBoostSection(controller),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'CEO',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              const Text('Bronze', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 8),
              const Text('1/11', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  // Add settings functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyTasks() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTaskCard(
              'Daily reward', '19:35', 'assets/images/calender_icon.png'),
          _buildTaskCard(
              'Daily cipher', '14:35', 'assets/images/lock_icon.png'),
          _buildTaskCard(
              'Daily combo', '07:35', 'assets/images/daily_combo_icon.png'),
        ],
      ),
    );
  }

  Widget _buildTaskCard(String title, String time, String img) {
    return Card(
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(
              img,
              height: 50.h,
              width: 50.w,
            ),
            Text(title, style: const TextStyle(color: Colors.white)),
            Text(time, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDisplay(HomeController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/coin_icon.png',
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
          const SizedBox(width: 8),
          Obx(() => Text(
                '${controller.currencyCount}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCharacterDisplay(
      BoxConstraints constraints, HomeController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTapDown: (details) {
              controller.handleTap(details, constraints.biggest);
              HapticFeedback.lightImpact();
            },
            child: AnimatedBuilder(
              animation: controller.scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: controller.scaleAnimation.value,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      margin: EdgeInsets.all(34.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            controller.isUpdating
                                ? Colors.grey  // Visual feedback when updating
                                : const Color.fromARGB(255, 4, 57, 101),
                            const Color.fromARGB(255, 31, 32, 33),
                          ],
                          center: Alignment.center,
                          radius: 0.8,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/tap_logo.png',
                        height: 20.h,
                        width: 20.w,
                      ),
                    )
                    ,
                  ),
                );
              },
            ),
          ),
          Obx(() {
            if (controller.showAnimation.value) {
              return AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return Positioned(
                    top: controller.topPosition.value -
                        controller.animationController.value * 50,
                    left: controller.leftPosition.value,
                    child: Opacity(
                      opacity: 1.0 - controller.animationController.value,
                      child: const Text(
                        '+1',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildBoostSection(HomeController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.flash_on, color: Colors.amber),
              const SizedBox(width: 8),
              Obx(() => Text(
                    '${controller.tapCount} / 1000',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Add boost functionality
            },
            child: const Text('Boost'),
          ),
        ],
      ),
    );
  }
}
