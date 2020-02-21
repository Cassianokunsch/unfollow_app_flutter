String loginMutation = r'''
mutation login($username: String!, $password: String!){
  login(password: $password, username: $username){
    token
    message
    user{
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
}
''';
