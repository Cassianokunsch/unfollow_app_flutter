import 'package:unfollow_app_flutter/models/followers.dart';

class MyListFollowersResponse {
  final String nextMaxId;
  final List<Followers> followers;

  MyListFollowersResponse({
    this.nextMaxId,
    this.followers,
  });

  factory MyListFollowersResponse.fromJson(Map<String, dynamic> json) {
    return MyListFollowersResponse(
      nextMaxId: json['nextMaxId'],
      followers: List<Followers>.from(
          json['followers'].map((x) => Followers.fromJson(x))),
    );
  }
}
