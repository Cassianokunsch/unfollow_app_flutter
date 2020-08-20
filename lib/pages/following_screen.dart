import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/components/list_card_user.dart';
import 'package:unfollow_app_flutter/graphql/query.dart';
import 'package:unfollow_app_flutter/models/my_followings_dto.dart';
import 'package:unfollow_app_flutter/models/user.dart';
import 'package:unfollow_app_flutter/pages/authorization_code_view.dart';
import 'package:unfollow_app_flutter/pages/login_screen.dart';
import 'package:unfollow_app_flutter/storage.dart';

class FollowingScreen extends StatefulWidget {
  static String routeName = '/followings';

  const FollowingScreen({Key key}) : super(key: key);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  GraphQLClient _client;
  bool _isLoading = true;

  String _nextPage = '';
  List<User> _followings = [];

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
    MyFollowingsDto response;
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(Queries.myFollowings()),
        variables: <String, String>{'nextPage': _nextPage},
      ),
    );

    if (result.hasException) {
      var message = result.exception.graphqlErrors[0].message;
      if (message.contains('Autorização pendente')) {
        Navigator.pushReplacementNamed(context, AutorizationCodeView.routeName);
      } else if (message.contains('Não há sessão para esse usuário!')) {
        await setToken('');
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(message), duration: Duration(seconds: 3)));
    } else {
      response = MyFollowingsDto.fromJson(result.data['myFollowings']);
    }

    setState(() {
      _isLoading = false;
      _nextPage = response?.nextPage;
      _followings.addAll(response.followings);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Seguindo')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListCardUser(
              scrollController: _scrollController,
              listUsers: _followings,
              icon: Icons.arrow_forward_ios,
              onPressedIcon: (int index) => print('followings'),
              onTap: () => print('tap followings'),
            ),
    );
  }
}
