String myListFollowers = r'''
query myListFollowers($maxId: String!){
  myListFollowers(maxId: $maxId){
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

String myListFollowings = r'''
query myListFollowings($maxId: String!){
  myListFollowings(maxId: $maxId){
    nextMaxId
    size
    followings{
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
