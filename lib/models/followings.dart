import 'package:unfollow_app_flutter/models/user.dart';

class Followings extends User {
  Followings(
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

  Followings.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
