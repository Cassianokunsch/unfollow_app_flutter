import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/components/list_card_user.dart';
import 'package:unfollow_app_flutter/graphql/query.dart';
import 'package:unfollow_app_flutter/models/my_list_followings_response.dart';
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
  MyListFollowingsResponse _myListFollowingsResponse;

  String _maxId = '';
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
    MyListFollowingsResponse response;
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(myListFollowings),
        variables: <String, String>{'maxId': _maxId},
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
      response =
          MyListFollowingsResponse.fromJson(result.data['myListFollowings']);
    }

    setState(() {
      _isLoading = false;
      _maxId = response.nextMaxId;
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
              listUsers: _myListFollowingsResponse.followings,
              icon: Icons.arrow_forward_ios,
              onPressedIcon: (int index) => print('followings'),
              onTap: () => print('tap followings'),
            ),
    );
  }
}
