import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/graphql/queries.dart';
import 'package:unfollow_app_flutter/models/user.dart';
import 'package:unfollow_app_flutter/storage.dart';

class HomeView extends StatefulWidget {
  static String tag = 'home';

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<HomeView> {
  UserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    UserInfo user = await getUser();
    setState(() {
      _userInfo = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              profileImage(_userInfo.profilePicUrl),
              SizedBox(height: 20.0),
              Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(_userInfo.fullName),
                        Text('@' + _userInfo.username),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      userInfoFollowFollowing(
                        "Seguidores",
                        _userInfo.followerCount.toString(),
                      ),
                      userInfoFollowFollowing(
                        "Seguindo",
                        _userInfo.followingCount.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
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
