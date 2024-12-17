import 'package:flutter/material.dart';
import 'package:tap_coin/common/bottom_navigation.dart';

class EarnScreen extends StatelessWidget {
  const EarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // print("EarnScreen build"); // Debug print
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'Earn Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
