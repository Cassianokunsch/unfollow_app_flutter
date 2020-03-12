import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/graphql/query.dart';
import 'package:unfollow_app_flutter/models/me_response.dart';
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
  MeResponse _me;
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
      client = GraphQLProvider.of(context).value;

      QueryResult result = await client.query(
        QueryOptions(documentNode: gql(me)),
      );

      if (result.hasException) {
        if (result.exception.graphqlErrors[0].message
            .contains('Autorização pendente')) {
          Navigator.pushReplacementNamed(
              context, AutorizationCodeView.routeName);
        } else if (result.exception.graphqlErrors[0].message
            .contains('Não há sessão para esse usuário!')) {
          await setToken('');
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      } else {
        await setUser(result.data['me']);
        setState(() {
          _me = MeResponse.fromJson(result.data['me']);
          isLoading = false;
        });
      }
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
            : buildBody(_me),
      ),
    );
  }

  Query buildQuery(BuildContext context) {
    return Query(
      options: QueryOptions(documentNode: gql(me)),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          if (result.exception.graphqlErrors[0].message
              .contains('Autorização pendente')) {
            Navigator.pushReplacementNamed(
                context, AutorizationCodeView.routeName);
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
        return buildBody(MeResponse.fromJson(result.data['me']));
      },
    );
  }

  Container buildBody(MeResponse me) {
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
          Expanded(
            child: ListView(
              children: <Widget>[
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
                  title: 'Não te seguem',
                  subtitle: me.followingCount.toString(),
                  routeName: UnfollowScreen.routeName,
                ),
              ],
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
