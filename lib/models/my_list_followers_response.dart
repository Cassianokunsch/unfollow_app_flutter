import 'package:unfollow_app_flutter/models/user.dart';

class MyListFollowersResponse {
  final String nextMaxId;
  final List<User> followers;

  MyListFollowersResponse({
    this.nextMaxId,
    this.followers,
  });

  factory MyListFollowersResponse.fromJson(Map<String, dynamic> json) {
    return MyListFollowersResponse(
      nextMaxId: json['nextMaxId'],
      followers:
          List<User>.from(json['followers'].map((x) => User.fromJson(x))),
    );
  }
}
