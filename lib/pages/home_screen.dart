import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/graphql/query.dart';
import 'package:unfollow_app_flutter/models/user_info_dto.dart';
import 'package:unfollow_app_flutter/pages/authorization_code_view.dart';
import 'package:unfollow_app_flutter/pages/follower_screen.dart';
import 'package:unfollow_app_flutter/pages/following_screen.dart';
import 'package:unfollow_app_flutter/pages/login_screen.dart';
import 'package:unfollow_app_flutter/pages/unfollow_screen.dart';

import 'package:unfollow_app_flutter/storage.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  GraphQLClient client;
  UserInfoDto _me;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getMe();
  }

  _getMe() async {
    _me = await getUser();

    if (_me != null) {
      setState(() {
        isLoading = false;
      });
    } else {
      await _refreshUserData();
    }
  }

  Future<Null> _refreshUserData() async {
    client = GraphQLProvider.of(context).value;

    QueryResult result = await client.query(
      QueryOptions(
          documentNode: gql(Queries.userInfo()), variables: {"pk": ''}),
    );

    if (result.hasException) {
      if (result.exception.graphqlErrors[0].message
          .contains('Autorização pendente')) {
        Navigator.pushReplacementNamed(context, AutorizationCodeView.routeName);
      } else if (result.exception.graphqlErrors[0].message
          .contains('Não há sessão para esse usuário!')) {
        await setToken('');
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } else {
      await setUser(result.data['userInfo']);
      setState(() {
        _me = UserInfoDto.fromJson(result.data['userInfo']);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Buscando dados da conta...')
                  ],
                ),
              )
            : buildContent(_me),
      ),
    );
  }

  RefreshIndicator buildContent(UserInfoDto me) {
    var refreshKey = GlobalKey<RefreshIndicatorState>();
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: _refreshUserData,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
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
                            image: NetworkImage(me.profilePicUrl),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(me.fullName),
                            Text('@' + me.username),
                            SizedBox(height: 20),
                            Text(me.biography),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TileAction(
                  title: 'Seguidores',
                  subtitle: me.followerCount.toString(),
                  routeName: FollowerScreen.routeName,
                ),
                TileAction(
                  title: 'Seguindo',
                  subtitle: me.followingCount.toString(),
                  routeName: FollowingScreen.routeName,
                ),
                TileAction(
                  title: 'Não seguem você',
                  subtitle: "clique para ver",
                  routeName: UnfollowScreen.routeName,
                ),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(me.feed.pictures[index].url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.favorite,
                                color: Colors.pink,
                                size: 20.0,
                              ),
                              Text(
                                me.feed.pictures[index].likeCount.toString(),
                              ),
                              SizedBox(width: 20),
                              Icon(
                                Icons.message,
                                color: Colors.grey,
                                size: 20.0,
                              ),
                              Text(
                                me.feed.pictures[index].commentCount.toString(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(5),
                );
              },
              childCount: me.feed.size,
            ),
          ),
        ],
      ),
    );
  }
}

class TileAction extends StatelessWidget {
  const TileAction({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.routeName,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.arrow_forward_ios),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () => Navigator.pushNamed(context, routeName),
    );
  }
}
