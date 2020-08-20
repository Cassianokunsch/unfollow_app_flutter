import 'package:unfollow_app_flutter/models/user.dart';

class MyFollowingsDto {
  final int size;
  final String nextPage;
  final List<User> followings;

  MyFollowingsDto({
    this.size,
    this.nextPage,
    this.followings,
  });

  factory MyFollowingsDto.fromJson(Map<String, dynamic> json) {
    return MyFollowingsDto(
      size: json['size'],
      nextPage: json['nextPage'],
      followings:
          List<User>.from(json['followings'].map((x) => User.fromJson(x))),
    );
  }
}
