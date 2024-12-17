import 'package:flutter/material.dart';
import 'package:tap_coin/common/bottom_navigation.dart';

class AirdropScreen extends StatelessWidget {
  const AirdropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Debug print
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'Airdrop Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
