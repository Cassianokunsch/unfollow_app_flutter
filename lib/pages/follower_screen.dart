import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/components/list_card_user.dart';
import 'package:unfollow_app_flutter/graphql/query.dart';
import 'package:unfollow_app_flutter/models/my_followers_dto.dart';
import 'package:unfollow_app_flutter/models/user.dart';
import 'package:unfollow_app_flutter/pages/authorization_code_view.dart';
import 'package:unfollow_app_flutter/pages/login_screen.dart';
import 'package:unfollow_app_flutter/pages/user_info.dart';
import 'package:unfollow_app_flutter/storage.dart';

class FollowerScreen extends StatefulWidget {
  static String routeName = '/followers';

  const FollowerScreen({Key key}) : super(key: key);

  @override
  _FollowerScreenState createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  GraphQLClient _client;
  bool _isLoading = true;
  List<User> _followers = [];
  String _nextPage = '';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getData();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _client = GraphQLProvider.of(context).value;
    _getData();
  }

  _getData() async {
    MyFollowersDto response;
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(Queries.myFollowers()),
        variables: <String, String>{'nextPage': _nextPage},
      ),
    );

    if (result.hasException) {
      var message = result.exception.graphqlErrors[0].message;
      if (message.contains(
          "Autorização pendente! Use a mutation sendCodeChallenge para inserir o código de segurança!")) {
        Navigator.pushReplacementNamed(context, AutorizationCodeView.routeName);
      } else if (message
          .contains("Não autorizado. Não há sessão para esse usuário!")) {
        await setToken('');
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(message), duration: Duration(seconds: 3)));
    } else {
      response = MyFollowersDto.fromJson(result.data['myFollowers']);
    }

    setState(() {
      _isLoading = false;
      _nextPage = response?.nextPage;
      _followers.addAll(response.followers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Seguidores')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListCardUser(
              scrollController: _scrollController,
              listUsers: _followers,
              icon: Icons.arrow_forward_ios,
              onPressedIcon: (int index) => print('followers $index'),
              onTap: (int index) {
                print('tap followers $index');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoScreen(_followers[index]),
                  ),
                );
              },
            ),
    );
  }
}
