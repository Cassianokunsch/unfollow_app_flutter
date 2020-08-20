class Queries {
  static String myFollowers() {
    return r'''
            query myFollowers($nextPage: String!){
              myFollowers(nextPage: $nextPage){
                nextPage
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
  }

  static String myFollowings() {
    return r'''
            query myFollowings($nextPage: String!){
              myFollowings(nextPage: $nextPage){
                nextPage
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
  }

  static String myUnfollowers() {
    return r'''
            query myUnfollowers($nextPage: String!){
              myUnfollowers(nextPage: $nextPage){
                nextPage
                size
                unfollowers {
                  pk
                  username
                  fullName
                  profilePicUrl
                }
              }
            }
            ''';
  }

  static String userInfo() {
    return r'''
            query($pk:String){
              userInfo(pk:$pk){
                pk
                username
                fullName
                isPrivate
                profilePicUrl
                isVerified
                followerCount
                followingCount
                biography
                feed {
                  nextPage
                  size
                  pictures {
                    pk
                    commentCount
                    likeCount
                    url
                  }
                }
              }
              }
            ''';
  }
}
