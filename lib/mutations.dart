String loginMutation = r'''
mutation login($username: String!, $password: String!){
  login(password: $password, username: $username){
    token
  }
}
''';
