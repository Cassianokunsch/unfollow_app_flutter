import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/graphql/query.dart';
import 'package:unfollow_app_flutter/models/user_info.dart';
import 'package:unfollow_app_flutter/pages/authorization_code_view.dart';
import 'package:unfollow_app_flutter/pages/user_list_screen.dart';

import 'package:unfollow_app_flutter/storage.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home';

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Query(
          options: QueryOptions(documentNode: gql(me)),
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
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Bucando suas informações...')
                  ],
                ),
              );
            }
            setUser(result.data['me']);
            return buildBody(UserInfo.fromJson(result.data['me']));
          },
        ),
      ),
    );
  }

  Container buildBody(UserInfo userInfo) {
    print(userInfo.username);
    return Container(
      child: Column(
        children: <Widget>[
          profileImage(userInfo.profilePicUrl),
          SizedBox(height: 20.0),
          Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Text(userInfo.fullName),
                    Text('@' + userInfo.username),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  userInfoFollowFollowing(
                    "Seguidores",
                    userInfo.followerCount.toString(),
                  ),
                  userInfoFollowFollowing(
                    "Seguindo",
                    userInfo.followingCount.toString(),
                  ),
                  userInfoFollowFollowing(
                    "Não te segue",
                    userInfo.followingCount.toString(),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserListScreen(title: 'Seguidores'),
                      ),
                    );
                  },
                  child: Text('Seguidores')),
              FlatButton(onPressed: () {}, child: Text('Seguindo')),
            ],
          )
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
            Text(count, style: TextStyle(fontSize: 20.0)),
            Text(description, style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
