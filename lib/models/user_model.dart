import 'package:tap_coin/common/app_constanats.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  int coinCount;
  int tapCount;
  String rank;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.coinCount = 0,
    this.tapCount = AppConstants.defaultTapCount,
    this.rank = AppConstants.defaultRank,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'coinCount': coinCount,
        'tapCount': tapCount,
        'rank': rank,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'] ?? '',
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        coinCount: json['coinCount'] ?? 0,
        tapCount: json['tapCount'] ?? AppConstants.defaultTapCount,
        rank: json['rank'] ?? AppConstants.defaultRank,
      );
}
