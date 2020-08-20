import 'package:unfollow_app_flutter/models/feed_dto.dart';

class UserInfoDto {
  String pk;
  String username;
  String fullName;
  bool isPrivate;
  String profilePicUrl;
  String profilePicId;
  bool isVerified;
  bool hasAnonymousProfilePicture;
  int latestReelMedia;
  int followerCount;
  int followingCount;
  String biography;
  Feed feed;

  UserInfoDto(
    this.pk,
    this.username,
    this.fullName,
    this.isPrivate,
    this.profilePicUrl,
    this.profilePicId,
    this.isVerified,
    this.hasAnonymousProfilePicture,
    this.latestReelMedia,
    this.followerCount,
    this.followingCount,
    this.biography,
    this.feed,
  );

  UserInfoDto.fromJson(Map<String, dynamic> json) {
    this.pk = json['pk'];
    this.username = json['username'];
    this.fullName = json['fullName'];
    this.isPrivate = json['isPrivate'];
    this.profilePicUrl = json['profilePicUrl'];
    this.profilePicId = json['profilePicId'];
    this.isVerified = json['isVerified'];
    this.hasAnonymousProfilePicture = json['hasAnonymousProfilePicture'];
    this.latestReelMedia = json['latestReelMedia'];
    this.followerCount = json['followerCount'];
    this.followingCount = json['followingCount'];
    this.biography = json['biography'];
    this.feed = Feed.fromJson(json['feed']);
  }
}
