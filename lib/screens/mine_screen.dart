import 'package:flutter/material.dart';
import 'package:tap_coin/common/bottom_navigation.dart';

class MineScreen extends StatelessWidget {
  const MineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // print("MineScreen build"); // Debug print
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'Mine Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
