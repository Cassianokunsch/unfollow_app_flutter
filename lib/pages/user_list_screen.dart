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
  GraphQLClient client;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List _listUsers;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    client = QueryState.initState();
  }

  @override
  Widget build(BuildContext context) {
    client = GraphQLProvider.of(context).value;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: isLoading
          ? CircularProgressIndicator()
          : Column(
              children: <Widget>[
                ListView.builder(
                  itemCount: _listUsers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        Text(index.toString()),
                        FlatButton(
                          onPressed: () {
                            print(index);
                          },
                          child: Text("Remove"),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }

  Query buildQuery(BuildContext context) {
    return Query(
      options: QueryOptions(documentNode: buildGql()),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          if (result.exception.graphqlErrors[0].message
              .contains('Autorização pendente')) {
            Navigator.pushReplacementNamed(context, AutorizationCodeView.tag);
          }
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Center(child: CircularProgressIndicator());
        }

        List _listUsers;

        if (widget.title.compareTo('Seguidores') == 0) {
          print('Seguidores');
          _listUsers = result.data['myListFollowers']['followers'];
        } else if (widget.title.compareTo('Seguindo') == 0) {
          print('Seguindo');
          _listUsers = result.data['myListFollowings']['followings'];
        } else {
          print(widget.title.compareTo('Seguindo'));
          _listUsers = result.data['myListUnfollowers'];
        }

        return buildListView(_listUsers);
      },
    );
  }

  DocumentNode buildGql() {
    if (widget.title.compareTo('Seguidores') == 0) {
      print('Seguidores');
      return gql(myListFollowers);
    } else if (widget.title.compareTo('Seguindo') == 0) {
      print('Seguindo');
      return gql(myListFollowings);
    } else {
      print(widget.title.compareTo('Seguindo'));
      return gql(myListUnfollowers);
    }
  }

  ListView buildListView(List _listUsers) {
    return ListView.builder(
      itemCount: _listUsers.length,
      itemBuilder: (context, index) {
        return CardUser(
          fullName: _listUsers[index]['fullName'],
          img: _listUsers[index]['profilePicUrl'],
          onDelete: () async {
            final Map<String, dynamic> response = (await client.mutate(
              MutationOptions(
                  documentNode: gql(unfollow),
                  variables: <String, String>{
                    'pk': _listUsers[index]['pk'],
                  }),
            ))
                .data;
            print(response);
            setState(() {
              _listUsers.removeAt(index);
            });
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(response['unfollow']['message']),
              duration: Duration(seconds: 3),
            ));
          },
          username: _listUsers[index]['username'],
        );
      },
    );
  }
}
