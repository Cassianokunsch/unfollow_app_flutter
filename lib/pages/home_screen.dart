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
                    Text('Buscando suas informações...')
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(userInfo.profilePicUrl),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userInfo.fullName),
                      Text('@' + userInfo.username),
                      SizedBox(height: 20),
                      Text(userInfo.biography),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Seguidores'),
                  subtitle: Text(userInfo.followerCount.toString()),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(title: 'Seguidores'),
                    ),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Seguindo'),
                  subtitle: Text(userInfo.followingCount.toString()),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(title: 'Seguindo'),
                    ),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Não te seguem'),
                  subtitle: Text(userInfo.followingCount.toString()),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserListScreen(title: 'Não te seguem'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
