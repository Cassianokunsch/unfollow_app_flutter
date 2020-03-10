import 'package:flutter/material.dart';
import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/components/card_user.dart';
import 'package:unfollow_app_flutter/graphql/mutation.dart';
import 'package:unfollow_app_flutter/graphql/query.dart';
import 'package:unfollow_app_flutter/pages/authorization_code_view.dart';

class UserListScreen extends StatefulWidget {
  static String tag = '/user_list';
  final String title;

  const UserListScreen({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  GraphQLClient client;
  List _listUsers = [];
  bool isLoading = true;
  String maxId = '';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  getData() async {
    client = GraphQLProvider.of(context).value;
    String typeQuery;
    String typeUser;
    DocumentNode query;

    if (widget.title.compareTo('Seguidores') == 0) {
      query = gql(myListFollowers);
      typeQuery = 'myListFollowers';
      typeUser = 'followers';
    } else if (widget.title.compareTo('Seguindo') == 0) {
      query = gql(myListFollowings);
      typeQuery = 'myListFollowings';
      typeUser = 'followings';
    } else {
      query = gql(myListUnfollowers);
      typeQuery = 'myListUnfollowers';
      typeUser = 'unfollowers';
    }

    QueryResult result = await client.query(
      QueryOptions(
        documentNode: query,
        variables: <String, String>{'maxId': maxId},
      ),
    );

    if (result.hasException) {
      if (result.exception.graphqlErrors[0].message
          .contains('Autorização pendente')) {
        Navigator.pushReplacementNamed(context, AutorizationCodeView.tag);
      }
      print(result.exception.toString());
    }

    setState(() {
      _listUsers.addAll(result.data[typeQuery][typeUser]);
      isLoading = false;
      maxId = result.data[typeQuery]['nextMaxId'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : buildListView(),
    );
  }

  _unFollowUser(index) async {
    final Map<String, dynamic> response = (await client.mutate(
      MutationOptions(documentNode: gql(unfollow), variables: <String, String>{
        'pk': _listUsers[index]['pk'],
      }),
    ))
        .data;
    setState(() {
      _listUsers.removeAt(index);
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(response['unfollow']['message']),
      duration: Duration(seconds: 3),
    ));
  }

  ListView buildListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _listUsers.length + 1,
      itemBuilder: (context, index) {
        if (index == _listUsers.length) {
          return Center(child: CircularProgressIndicator());
        }

        return CardUser(
          fullName: _listUsers[index]['fullName'],
          img: _listUsers[index]['profilePicUrl'],
          onDelete: () => _unFollowUser(index),
          username: _listUsers[index]['username'],
        );
      },
    );
  }
}
