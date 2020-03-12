import 'package:unfollow_app_flutter/models/user.dart';

class MyListFollowingsResponse {
  final String nextMaxId;
  final List<User> followings;

  MyListFollowingsResponse({
    this.nextMaxId,
    this.followings,
  });

  factory MyListFollowingsResponse.fromJson(Map<String, dynamic> json) {
    return MyListFollowingsResponse(
      nextMaxId: json['nextMaxId'],
      followings:
          List<User>.from(json['followings'].map((x) => User.fromJson(x))),
    );
  }
}
