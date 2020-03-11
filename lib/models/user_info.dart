import 'package:unfollow_app_flutter/models/user.dart';

class UserInfo {
  int followerCount;
  int followingCount;
  String biography;
  User user;

  UserInfo(
    this.followerCount,
    this.followingCount,
    this.biography,
    this.user,
  );

  UserInfo.fromJson(Map<String, dynamic> json) {
    this.followerCount = json['followerCount'];
    this.followingCount = json['followingCount'];
    this.biography = json['biography'];
    this.user = User.fromJson(json);
  }
}
