import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/graphql/queries.dart';

import 'package:unfollow_app_flutter/pages/authorization_code_view.dart';

class HomeView extends StatefulWidget {
  static String tag = 'home';

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Query(
          options: QueryOptions(
            documentNode: gql('''
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
            '''),
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              if (result.exception.graphqlErrors[0].message
                  .contains('Autorização pendente')) {
                Navigator.pushReplacementNamed(
                    context, AutorizationCodeView.tag);
              }
              return Text(result.exception.toString());
            }

            if (result.loading) {
              return Center(child: CircularProgressIndicator());
            }

            return buildContainer(result.data['me']);
          },
        ),
      ),
    );
  }

  Container buildContainer(userInfo) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          profileImage(userInfo['profilePicUrl']),
          SizedBox(height: 20.0),
          Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Text(userInfo['fullName']),
                    Text('@' + userInfo['username']),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  userInfoFollowFollowing(
                    "Seguidores",
                    userInfo['followerCount'].toString(),
                  ),
                  userInfoFollowFollowing(
                    "Seguindo",
                    userInfo['followingCount'].toString(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Center profileImage(uri) {
    return Center(
      child: Container(
        width: 190.0,
        height: 190.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(uri),
          ),
        ),
      ),
    );
  }

  Expanded userInfoFollowFollowing(description, count) {
    return Expanded(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              count,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  Query buildQuery() {
    return Query(
      options: QueryOptions(documentNode: gql(myListFollowers)),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (result.data == null) {
          print(result.exception);
          return Text("No Data Found !");
        }

        List followers = result.data['myListFollowers']['followers'];

        return ListView.builder(
          itemCount: followers.length,
          itemBuilder: (context, index) {
            final repository = followers[index];

            return Text(repository['username']);
          },
        );
      },
    );
  }
}
