import 'package:unfollow_app_flutter/models/followings.dart';

class MyListFollowingResponse {
  final String nextMaxId;
  final List<Followings> followings;

  MyListFollowingResponse({
    this.nextMaxId,
    this.followings,
  });

  factory MyListFollowingResponse.fromJson(Map<String, dynamic> json) {
    return MyListFollowingResponse(
      nextMaxId: json['nextMaxId'],
      followings: List<Followings>.from(
          json['Following'].map((x) => Followings.fromJson(x))),
    );
  }
}
