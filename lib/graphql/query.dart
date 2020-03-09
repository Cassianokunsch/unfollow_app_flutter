String myListFollowers = '''
query{
  myListFollowers{
    nextMaxId
    size
    followers{
      pk
      username
      fullName
      profilePicUrl
    }
  }
}
''';

String myListFollowings = '''
query{
  myListFollowers{
    nextMaxId
    size
    followers{
      pk
      username
      fullName
      profilePicUrl
    }
  }
}
''';

String myListUnfollowers = '''
query{
  myListUnfollowers{
    pk
    username
    fullName
    profilePicUrl
  }
}
''';

String me = '''
query{
  me{
    pk
    username
    fullName
    isPrivate
    profilePicUrl
    profilePicId
    isVerified
    hasAnonymousProfilePicture
    latestReelMedia
    followerCount
    followingCount
    biography
  }
}
''';
