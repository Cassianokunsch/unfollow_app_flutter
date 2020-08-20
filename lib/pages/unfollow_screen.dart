import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/components/list_card_user.dart';
import 'package:unfollow_app_flutter/graphql/mutation.dart';
import 'package:unfollow_app_flutter/graphql/query.dart';
import 'package:unfollow_app_flutter/models/my_unfollowers_dto.dart';
import 'package:unfollow_app_flutter/models/user.dart';
import 'package:unfollow_app_flutter/pages/authorization_code_view.dart';
import 'package:unfollow_app_flutter/pages/login_screen.dart';
import 'package:unfollow_app_flutter/storage.dart';

class UnfollowScreen extends StatefulWidget {
  static String routeName = '/unfollow';

  const UnfollowScreen({Key key}) : super(key: key);

  @override
  _UnfollowScreenState createState() => _UnfollowScreenState();
}

class _UnfollowScreenState extends State<UnfollowScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  GraphQLClient _client;
  bool _isLoading = true;

  List<User> _myUnfollowDto = [];
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
    MyUnfollowersDto response;
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(Queries.myUnfollowers()),
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
      response = MyUnfollowersDto.fromJson(result.data['myUnfollowers']);
    }

    setState(() {
      _isLoading = false;
      _myUnfollowDto.addAll(response.unfollowers);
    });
  }

  _unFollowUser(index) async {
    final Map<String, dynamic> response = (await _client.mutate(
      MutationOptions(
          documentNode: gql(Mutations.unfollow),
          variables: <String, String>{
            'pk': _myUnfollowDto[index].pk,
          }),
    ))
        .data;
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
          content: Text(response['unfollow']['message']),
          duration: Duration(seconds: 3)),
    );
    setState(() {
      _myUnfollowDto.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Não te seguem')),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _myUnfollowDto.length > 0
                ? ListCardUser(
                    scrollController: _scrollController,
                    listUsers: _myUnfollowDto,
                    icon: Icons.delete,
                    onPressedIcon: (int index) => _unFollowUser(index),
                    onTap: () => print('tap unfollow'),
                  )
                : Center(
                    child: Text("Nada todo mundo que você segue te segue!")));
  }
}
