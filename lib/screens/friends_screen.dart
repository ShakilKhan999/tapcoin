// import 'package:flutter/material.dart';
// import 'package:hamstar_coin/common/bottom_navigation.dart';

// class FriendsScreen extends StatelessWidget {
//   const FriendsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // print("FriendsScreen build"); // Debug print
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: const Center(
//         child: Text(
//           'Friends Screen',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tap_coin/common/bottom_navigation.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Web layout
            return _buildWebLayout(context);
          } else {
            // Mobile layout
            return _buildMobileLayout(context);
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Invite friends!',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'You and your friend will receive bonuses',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildInviteCard(
              'Invite a friend',
              '+5,000 for you and your friend',
              'assets/images/gift_box.png',
            ),
            const SizedBox(height: 16),
            _buildInviteCard(
              'Invite a friend with Telegram Premium',
              '+25,000 for you and your friend',
              'assets/images/premium_gift_box.png',
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text('More bonuses',
                  style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 16),
            _buildFriendsList(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Invite a friend'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteCard(String title, String bonus, String assetPath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(assetPath, width: 48, height: 48),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(bonus, style: const TextStyle(color: Colors.amber)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('List of your friends',
                  style: TextStyle(color: Colors.white)),
              Icon(Icons.refresh, color: Colors.white),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'You haven\'t invited anyone yet',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
