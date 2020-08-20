import 'package:unfollow_app_flutter/models/user.dart';

class MyUnfollowersDto {
  final int size;
  final String nextPage;
  final List<User> unfollowers;

  MyUnfollowersDto({
    this.nextPage,
    this.size,
    this.unfollowers,
  });

  factory MyUnfollowersDto.fromJson(Map<String, dynamic> json) {
    return MyUnfollowersDto(
      size: json['size'],
      nextPage: json['nextPage'],
      unfollowers:
          List<User>.from(json['unfollowers'].map((x) => User.fromJson(x))),
    );
  }
}
