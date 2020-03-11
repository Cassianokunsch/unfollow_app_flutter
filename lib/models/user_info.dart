import 'package:unfollow_app_flutter/models/user.dart';

class UserInfo extends User {
  int followerCount;
  int followingCount;
  String biography;

  UserInfo(
      String pk,
      String username,
      String fullName,
      bool isPrivate,
      String profilePicUrl,
      String profilePicId,
      bool isVerified,
      bool hasAnonymousProfilePicture,
      int latestReelMedia,
      this.followerCount,
      this.followingCount,
      this.biography)
      : super(pk, username, fullName, isPrivate, profilePicUrl, profilePicId,
            isVerified, hasAnonymousProfilePicture, latestReelMedia);

  UserInfo.fromJson(Map<String, dynamic> json)
      : super(
            json['pk'],
            json['username'],
            json['fullName'],
            json['isPrivate'],
            json['profilePicUrl'],
            json['profilePicId'],
            json['isVerified'],
            json['hasAnonymousProfilePicture'],
            json['latestReelMedia']) {
    this.followerCount = json['followerCount'];
    this.followingCount = json['followingCount'];
    this.biography = json['biography'];
  }
}
