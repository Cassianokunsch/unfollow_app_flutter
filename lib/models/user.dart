class User {
  String pk;
  String username;
  String fullName;
  bool isPrivate;
  String profilePicUrl;
  String profilePicId;
  bool isVerified;
  bool hasAnonymousProfilePicture;
  int latestReelMedia;

  User(
      this.pk,
      this.username,
      this.fullName,
      this.isPrivate,
      this.profilePicUrl,
      this.profilePicId,
      this.isVerified,
      this.hasAnonymousProfilePicture,
      this.latestReelMedia);

  User.fromJson(Map<String, dynamic> json) {
    this.pk = json['pk'];
    this.username = json['username'];
    this.fullName = json['fullName'];
    this.isPrivate = json['isPrivate'];
    this.profilePicUrl = json['profilePicUrl'];
    this.profilePicId = json['profilePicId'];
    this.isVerified = json['isVerified'];
    this.hasAnonymousProfilePicture = json['hasAnonymousProfilePicture'];
    this.latestReelMedia = json['latestReelMedia'];
  }
}
