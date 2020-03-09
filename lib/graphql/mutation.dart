String login = r'''
mutation login($username: String!, $password: String!){
  login(password: $password, username: $username){
    token
    message
  }
}
''';

String unfollow = r'''
mutation unfollow($pk: String!){
  unfollow(userIdToUnfollow: $pk){
    message
  }
}
''';

String sendCodeChallenge = r'''
mutation sendCodeChallenge($code: String!){
  sendCodeChallenge(code: $code){
    message
  }
}
''';
