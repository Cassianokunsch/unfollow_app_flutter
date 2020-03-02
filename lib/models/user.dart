class UserInfo {
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

  UserInfo.fromJson(Map<String, dynamic> json) {
    this.biography = json['biography'];
    this.followerCount = json['followerCount'];
    this.followingCount = json['followingCount'];
    this.fullName = json['fullName'];
    this.hasAnonymousProfilePicture = json['hasAnonymousProfilePicture'];
    this.isPrivate = json['isPrivate'];
    this.isVerified = json['isVerified'];
    this.latestReelMedia = json['latestReelMedia'];
    this.pk = json['pk'];
    this.profilePicId = json['profilePicId'];
    this.profilePicUrl = json['profilePicUrl'];
    this.username = json['username'];
  }
}
