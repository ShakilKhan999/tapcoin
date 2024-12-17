import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tap_coin/common/responsive_layout.dart';
import 'package:tap_coin/screens/airdrop_screen.dart';
import 'package:tap_coin/screens/earn_screen.dart';
import 'package:tap_coin/screens/friends_screen.dart';
import 'package:tap_coin/screens/home_screen.dart';
import 'package:tap_coin/screens/mine_screen.dart';

import '../controller/app_coontroller.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileView: _buildMobileNavBar(),
      desktopView: _buildDesktopNavBar(),
    );
  }

  Widget _buildMobileNavBar() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: const Color.fromARGB(255, 80, 78, 78),
            border: Border.all(
              width: 1,
            ),
          ),
          height: 70.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(index: 0, icon: Icons.home, label: 'Home'),
              buildNavItem(index: 1, icon: Icons.chat, label: 'Mine'),
              buildNavItem(index: 2, icon: Icons.person, label: 'Friends'),
              buildNavItem(index: 3, icon: Icons.attach_money, label: 'Earn'),
              buildNavItem(index: 4, icon: Icons.group, label: 'Airdrop'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNavBar() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: const Color.fromARGB(255, 80, 78, 78),
            border: Border.all(
              width: 1,
            ),
          ),
          height: 70.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildDesktopNavItem(index: 0, icon: Icons.home, label: 'Home'),
              buildDesktopNavItem(index: 1, icon: Icons.chat, label: 'Mine'),
              buildDesktopNavItem(
                  index: 2, icon: Icons.person, label: 'Friends'),
              buildDesktopNavItem(
                  index: 3, icon: Icons.attach_money, label: 'Earn'),
              buildDesktopNavItem(
                  index: 4, icon: Icons.group, label: 'Airdrop'),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildNavItem(
      {required int index, required IconData icon, required String label}) {
    return InkWell(
      onTap: () => _handleNavigation(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.h,
            height: 30.h,
            decoration: BoxDecoration(
              color: appController.selectedBottomItem.value == index
                  ? Colors.black
                  : Colors.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: appController.selectedBottomItem.value == index
                  ? Colors.white
                  : Colors.grey,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: appController.selectedBottomItem.value == index
                  ? Colors.white
                  : Colors.grey.withOpacity(0.6),
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDesktopNavItem(
      {required int index, required IconData icon, required String label}) {
    return InkWell(
      onTap: () => _handleNavigation(index),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: appController.selectedBottomItem.value == index
              ? Colors.black
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Icon(
              icon,
              color: appController.selectedBottomItem.value == index
                  ? Colors.white
                  : Colors.grey,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: appController.selectedBottomItem.value == index
                    ? Colors.white
                    : Colors.grey.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(int index) {
    appController.selectedBottomItem.value = index;
    switch (index) {
      case 0:
        Get.offAll(() => const HomeView(), transition: Transition.noTransition);
        break;
      case 1:
        Get.offAll(() => const MineScreen(),
            transition: Transition.noTransition);
        break;
      case 2:
        Get.offAll(() => const FriendsScreen(),
            transition: Transition.noTransition);
        break;
      case 3:
        Get.offAll(() => const EarnScreen(),
            transition: Transition.noTransition);
        break;
      case 4:
        Get.offAll(() => const AirdropScreen(),
            transition: Transition.noTransition);
        break;
    }
  }
}
