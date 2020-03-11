import 'package:unfollow_app_flutter/models/user.dart';

class Followers extends User {
  Followers(
      String pk,
      String username,
      String fullName,
      bool isPrivate,
      String profilePicUrl,
      String profilePicId,
      bool isVerified,
      bool hasAnonymousProfilePicture,
      int latestReelMedia)
      : super(pk, username, fullName, isPrivate, profilePicUrl, profilePicId,
            isVerified, hasAnonymousProfilePicture, latestReelMedia);

  Followers.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
