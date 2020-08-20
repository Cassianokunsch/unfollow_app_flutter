import 'package:unfollow_app_flutter/models/user.dart';

class MyFollowersDto {
  final int size;
  final String nextPage;
  final List<User> followers;

  MyFollowersDto({
    this.size,
    this.nextPage,
    this.followers,
  });

  factory MyFollowersDto.fromJson(Map<String, dynamic> json) {
    return MyFollowersDto(
      size: json['size'],
      nextPage: json['nextPage'],
      followers:
          List<User>.from(json['followers'].map((x) => User.fromJson(x))),
    );
  }
}
