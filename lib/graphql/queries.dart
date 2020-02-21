String myListFollowers = r'''
query{
  myListFollowers{
    nextMaxId
    size
    followers{
      username
    }
  }
}
''';
